--!strict
local Element = require("../Components/init")
local Services = require("../Shared/Services")
local EspConfig = require("./Config")
local Fonts = require("./Fonts")
local Visibility = require("./Visibility")
local Bounds = require("./Bounds")
local Utility = require("./Utility")
local BoxFeature = require("./Features/Box")
local HealthBarFeature = require("./Features/HealthBar")

local HighlightFeature = require("./Features/Highlight")
local TextFeature = require("./Features/TextFeature")

local Players = Services.Players
local RunService = Services.RunService
local UserInputService = Services.UserInputService

local esp = EspConfig.create()

local parent = (pcall(gethui) and gethui()) or Services.CoreGui
local screenGui = Element("ScreenGui", {
	Name = "CoCo_ESP",
	DisplayOrder = 999999,
	IgnoreGuiInset = true,
	ResetOnSpawn = false,
	Parent = parent,
})

local NameFeature = TextFeature({
	storageKey = "name",
	strokeKey = "nameStroke",
	featureKey = "name",
	positionFn = function(min, size)
		return UDim2.fromOffset(min.X + size.X / 2, min.Y - 17)
	end,
	textFn = function(state) return state.nameText end,
	colorKey = "nameColor",
	transparencyKey = "nameTransparency",
})

local DistanceFeature = TextFeature({
	storageKey = "distanceText",
	strokeKey = "distanceTextStroke",
	featureKey = "distance",
	positionFn = function(min, size)
		return UDim2.fromOffset(min.X + size.X / 2, min.Y + size.Y + 1)
	end,
	textFn = function(state) return tostring(state.distance) .. "M" end,
	colorKey = "distanceColor",
	transparencyKey = "distanceTransparency",
})

local HealthTextFeature = TextFeature({
	storageKey = "healthText",
	strokeKey = "healthTextStroke",
	featureKey = "health text",
	positionFn = function(min, size, state)
		return UDim2.fromOffset(min.X - 23, min.Y + size.Y * (1 - state.displayHealthRatio) - 3)
	end,
	textFn = function(state)
		if state.hideFullHealth and state.healthRatio >= 1 then return "" end
		return tostring(math.floor(state.healthValue + 0.5)) .. "%"
	end,
	colorKey = "healthTextColor",
	transparencyKey = "healthTextTransparency",
})

local ToolTextFeature = TextFeature({
	storageKey = "toolText",
	strokeKey = "toolTextStroke",
	featureKey = "tool text",
	positionFn = function(min, size, state)
		return UDim2.fromOffset(min.X + size.X / 2, min.Y + size.Y + (state.distanceEnabled and 15 or 1))
	end,
	textFn = function(state) return state.toolText end,
	colorKey = "toolTextColor",
	transparencyKey = "toolTextTransparency",
	visibleFn = function(text) return text ~= "" end,
})

type PlayerGuiData = {
	player: Player,
	root: Frame,
	features: { [string]: boolean },
	displayedHealthRatio: number,
	connections: { RBXScriptConnection },
	characterConns: { RBXScriptConnection },
	character: Model?,
	humanoid: Humanoid?,
	rootPart: BasePart?,
	health: number,
	maxHealth: number,
	teamState: string,
	teamColor: Color3?,
	fadeTransparency: number,
	leaving: boolean,
	lastState: {
		min: Vector2,
		size: Vector2,
		nameText: string,
		toolText: string,
		healthRatio: number,
		displayHealthRatio: number,
		distance: number,
		distanceEnabled: boolean,
	}?,
	tool: Tool?,
	bodyParts: { BasePart }?,
	box: Frame?,
	boxStroke: UIStroke?,
	boxOuterOutline: Frame?,
	boxOuterStroke: UIStroke?,
	boxInnerOutline: Frame?,
	boxInnerStroke: UIStroke?,
	boxFill: Frame?,
	name: TextLabel?,
	nameStroke: UIStroke?,
	healthOutline: Frame?,
	healthOutlineStroke: UIStroke?,
	healthBar: Frame?,
	healthGradient: UIGradient?,
	healthText: TextLabel?,
	healthTextStroke: UIStroke?,
	distanceText: TextLabel?,
	distanceTextStroke: UIStroke?,
	toolText: TextLabel?,
	toolTextStroke: UIStroke?,

	highlight: Highlight?,
}

local DISPATCH = {
	{ keys = { "box", "box fill" }, mod = BoxFeature },
	{ keys = { "health bar" },      mod = HealthBarFeature },
	{ keys = { "health text" },     mod = HealthTextFeature },
	{ keys = { "name" },            mod = NameFeature },
	{ keys = { "distance" },        mod = DistanceFeature },
	{ keys = { "tool text" },       mod = ToolTextFeature },

	{ keys = { "highlight" },       mod = HighlightFeature },
}

local playerData: { [Player]: PlayerGuiData } = {}
local renderConnection: RBXScriptConnection?
local reconcileQueued = false
local lastRender = 0
local camera: Camera = Services.Workspace.CurrentCamera


local localPlayer: Player? = Players.LocalPlayer

local function formatText(text: string): string
	if esp.TextCasing == "uppercase" then
		return string.upper(text)
	elseif esp.TextCasing == "lowercase" then
		return string.lower(text)
	end
	return text
end

local function getToolText(character: Model?): string
	if not character then return "" end
	local tool = character:FindFirstChildOfClass("Tool")
	if not tool then return "" end
	local text = tool.Name:gsub("^%[", ""):gsub("%]$", ""):gsub("[^%w%s_%-]", "")
	text = text:gsub("([a-z%d])([A-Z])", "%1 %2"):gsub("([A-Z]+)([A-Z][a-z])", "%1 %2")
	return esp.ToolTextCasing == "uppercase" and string.upper(text) or string.lower(text)
end

local function hideAllFeatures(data: PlayerGuiData)
	for _, entry in DISPATCH do
		entry.mod.update(data, nil, nil)
	end
end

local function setupCharacter(data: PlayerGuiData, character: Model)
	for _, cn in ipairs(data.characterConns) do
		cn:Disconnect()
	end
	data.characterConns = {}

	data.character = character
	data.humanoid = character:FindFirstChildOfClass("Humanoid")
	data.rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart?
	data.bodyParts = Utility.GetBodyParts(character)

	local function updateTool()
		local tool = character:FindFirstChildOfClass("Tool")
		if tool ~= data.tool then
			data.tool = tool
		end
	end

	table.insert(data.characterConns, character.ChildAdded:Connect(function(child)
		if child:IsA("Tool") then updateTool() end
	end))
	table.insert(data.characterConns, character.ChildRemoved:Connect(function(child)
		if child:IsA("Tool") then updateTool() end
	end))

	table.insert(data.characterConns, character.DescendantAdded:Connect(function(descendant: Instance)
		if descendant:IsA("BasePart") and descendant.Name == "HumanoidRootPart" then
			if not data.rootPart then
				data.rootPart = descendant :: BasePart?
			end
		end
		if descendant:IsA("Humanoid") then
			if not data.humanoid then
				data.humanoid = descendant
				data.health = descendant.Health
				data.maxHealth = descendant.MaxHealth
				table.insert(data.characterConns, descendant:GetPropertyChangedSignal("Health"):Connect(function()
					data.health = descendant.Health
					data.maxHealth = descendant.MaxHealth
				end))
				table.insert(data.characterConns, descendant:GetPropertyChangedSignal("RigType"):Connect(function()
					data.bodyParts = Utility.GetBodyParts(character)
				end))
			end
		end
		if descendant:IsA("Tool") then
			if descendant ~= data.tool then
				data.tool = descendant
			end
		end
		data.bodyParts = Utility.GetBodyParts(character)
	end))
	table.insert(data.characterConns, character.DescendantRemoving:Connect(function()
		data.bodyParts = Utility.GetBodyParts(character)
	end))

	updateTool()

	if data.humanoid then
		data.health = data.humanoid.Health
		data.maxHealth = data.humanoid.MaxHealth

		table.insert(data.characterConns, data.humanoid:GetPropertyChangedSignal("Health"):Connect(function()
			data.health = data.humanoid.Health
			data.maxHealth = data.humanoid.MaxHealth
		end))

		table.insert(data.characterConns, data.humanoid:GetPropertyChangedSignal("RigType"):Connect(function()
			data.bodyParts = Utility.GetBodyParts(character)
		end))
	end
end

local function clearCharacter(data: PlayerGuiData)
	for _, cn in ipairs(data.characterConns) do
		cn:Disconnect()
	end
	data.characterConns = {}
	data.character = nil
	data.humanoid = nil
	data.rootPart = nil
	data.bodyParts = nil
	data.tool = nil
	hideAllFeatures(data)
end

local function destroyPlayerGui(data: PlayerGuiData)
	for _, entry in DISPATCH do
		entry.mod.destroy(data)
	end
	for _, cn in ipairs(data.connections) do
		cn:Disconnect()
	end
	for _, cn in ipairs(data.characterConns) do
		cn:Disconnect()
	end
	data.root:Destroy()
	playerData[data.player] = nil
end

local function updatePlayerGui(data: PlayerGuiData)
	local features = data.features

	if data.leaving then
		data.fadeTransparency = math.min(data.fadeTransparency + 0.12, 1)
		if data.fadeTransparency >= 1 or not data.lastState then
			destroyPlayerGui(data)
			return
		end
		local ft = data.fadeTransparency
		local lastState = data.lastState
		local state = {
			min = lastState.min,
			size = lastState.size,
			healthRatio = lastState.healthRatio,
			healthValue = 0,
			displayHealthRatio = lastState.displayHealthRatio,
			distance = lastState.distance,
			nameText = formatText(lastState.nameText),
			toolText = lastState.toolText,
			distanceEnabled = lastState.distanceEnabled,
			boxColor = Visibility.TeamColor(esp, data, "box"),
			boxTransparency = 1 - (1 - Visibility.TeamTransparency(esp, data, "box")) * (1 - ft),
			boxFillColor = Visibility.TeamColor(esp, data, "box fill"),
			boxFillTransparency = 1 - (1 - Visibility.TeamTransparency(esp, data, "box fill")) * (1 - ft),
			nameColor = Visibility.TeamColor(esp, data, "name"),
			nameTransparency = 1 - (1 - Visibility.TeamTransparency(esp, data, "name")) * (1 - ft),
			healthColor = Visibility.TeamColor(esp, data, "health bar"),
			healthTransparency = 1 - (1 - Visibility.TeamTransparency(esp, data, "health bar")) * (1 - ft),
			healthTextColor = Visibility.TeamColor(esp, data, "health text"),
			healthTextTransparency = 1 - (1 - Visibility.TeamTransparency(esp, data, "health text")) * (1 - ft),
			distanceColor = Visibility.TeamColor(esp, data, "distance"),
			distanceTransparency = 1 - (1 - Visibility.TeamTransparency(esp, data, "distance")) * (1 - ft),
			toolTextColor = Visibility.TeamColor(esp, data, "tool text"),
			toolTextTransparency = 1 - (1 - Visibility.TeamTransparency(esp, data, "tool text")) * (1 - ft),
			highlightFillColor = Visibility.TeamColor(esp, data, "highlight"),
			highlightFillTransparency = 1 - (1 - Visibility.TeamTransparency(esp, data, "highlight")) * (1 - ft),
			highlightOutlineColor = esp.HighlightOutlineColor,
			highlightOutlineTransparency = 1 - (1 - esp.HighlightOutlineTransparency) * (1 - ft),
			highlightBehindWalls = esp.HighlightBehindWalls,
			hideFullHealth = esp.HideFullHealthText,
			healthBarGap = esp.HealthBarGap,
			healthBarWidth = esp.HealthBarWidth,
			healthBarOutline = esp.HealthBarOutline,
			healthBarYOffset = esp.HealthBarYOffset,
			healthBarGradientDirection = esp.HealthBarGradientDirection,
			visible = true,
			character = nil,
		}
		data.root.Position = UDim2.fromOffset(state.min.X, state.min.Y)
		data.root.Size = UDim2.fromOffset(state.size.X, state.size.Y)

		for _, entry in DISPATCH do
			entry.mod.ensure(data, screenGui)
			entry.mod.update(data, data, state)
		end
		return
	end

	local character = data.character
	local humanoid = data.humanoid
	local rootPart = data.rootPart

	if not camera or not character or not humanoid or not rootPart or humanoid.Health <= 0 then
		hideAllFeatures(data)
		return
	end

	if not features.needs2D then
		hideAllFeatures(data)
		if features["highlight"] then
			HighlightFeature.update(data, data, {
				visible = true,
				character = character,
				highlightBehindWalls = esp.HighlightBehindWalls,
				highlightFillColor = Visibility.TeamColor(esp, data, "highlight"),
				highlightFillTransparency = Visibility.TeamTransparency(esp, data, "highlight"),
				highlightOutlineColor = esp.HighlightOutlineColor,
				highlightOutlineTransparency = esp.HighlightOutlineTransparency,
			})
		end
		return
	end

	local player = data.player
	local isTarget = false
	local stateStr = data.teamState

	if player == localPlayer and not esp.ShowLocal then
		hideAllFeatures(data)
		return
	end
	if isTarget and not esp.ShowTarget then
		hideAllFeatures(data)
		return
	end
	if stateStr == "friendly" and not esp.ShowFriendlies then hideAllFeatures(data); return end
	if stateStr == "enemy" and not esp.ShowEnemies then hideAllFeatures(data); return end
	if stateStr == "neutral" and not esp.ShowNeutral then hideAllFeatures(data); return end
	if esp.TeamCheck and (stateStr == "friendly" or stateStr == "neutral") then hideAllFeatures(data); return end

	local localCharacter = Utility.GetCharacter(localPlayer)
	local localRoot = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")
	if localRoot and (rootPart.Position - (localRoot :: BasePart).Position).Magnitude > esp.MaxDistance then
		hideAllFeatures(data)
		return
	end

	local rootPos, rootOnScreen = camera:WorldToViewportPoint(rootPart.Position)
	if rootPos.Z <= 0 then hideAllFeatures(data); return end
	local vpSize = camera.ViewportSize
	local margin = 500
	if rootPos.X < -margin or rootPos.X > vpSize.X + margin or rootPos.Y < -margin or rootPos.Y > vpSize.Y + margin then
		hideAllFeatures(data)
		return
	end

	local parts: { BasePart }?
	if esp.DynamicBoxes then
		if esp.DynamicBoxesIncludeAll and character then
			parts = {}
			for _, v in character:GetChildren() do
				if v:IsA("BasePart") then
					parts[#parts + 1] = v :: BasePart
				end
			end
		else
			parts = data.bodyParts or {}
		end
	end

	local min, max, onScreen = Bounds.Get(esp, camera, parts, rootPart :: BasePart, character)
	if not onScreen or not min or not max then
		hideAllFeatures(data)
		return
	end

	local position = min
	local size = max - min
	local healthValue = data.health
	local maxHealth = math.max(data.maxHealth, 1)
	local healthRatio = math.clamp(healthValue / maxHealth, 0, 1)
	data.displayedHealthRatio += (healthRatio - data.displayedHealthRatio) * 0.18
	if math.abs(data.displayedHealthRatio - healthRatio) < 0.005 then
		data.displayedHealthRatio = healthRatio
	end
	local displayHealthRatio = data.displayedHealthRatio
	local distance = localRoot and math.floor((rootPart.Position - (localRoot :: BasePart).Position).Magnitude + 0.5) or 0

	local nameText = if player
		then (esp.UseDisplayName and player.DisplayName or player.Name)
		else character and character.Name or "unknown"

	local 	toolText = getToolText(character)

	data.root.Position = UDim2.fromOffset(position.X, position.Y)
	data.root.Size = UDim2.fromOffset(size.X, size.Y)

	if not data.leaving and data.fadeTransparency > 0 then
		data.fadeTransparency = math.max(data.fadeTransparency - 0.08, 0)
	end
	local ft = data.fadeTransparency

	local boxColor = Visibility.TeamColor(esp, data, "box")
	local boxTransparency = 1 - (1 - Visibility.TeamTransparency(esp, data, "box")) * (1 - ft)
	local boxFillColor = Visibility.TeamColor(esp, data, "box fill")
	local boxFillTransparency = 1 - (1 - Visibility.TeamTransparency(esp, data, "box fill")) * (1 - ft)
	local nameColor = Visibility.TeamColor(esp, data, "name")
	local nameTransparency = 1 - (1 - Visibility.TeamTransparency(esp, data, "name")) * (1 - ft)
	local healthColor = Visibility.TeamColor(esp, data, "health bar")
	local healthTransparency = 1 - (1 - Visibility.TeamTransparency(esp, data, "health bar")) * (1 - ft)
	local healthTextColor = Visibility.TeamColor(esp, data, "health text")
	local healthTextTransparency = 1 - (1 - Visibility.TeamTransparency(esp, data, "health text")) * (1 - ft)
	local distanceColor = Visibility.TeamColor(esp, data, "distance")
	local distanceTransparency = 1 - (1 - Visibility.TeamTransparency(esp, data, "distance")) * (1 - ft)
	local toolTextColor = Visibility.TeamColor(esp, data, "tool text")
	local toolTextTransparency = 1 - (1 - Visibility.TeamTransparency(esp, data, "tool text")) * (1 - ft)
	local highlightFillColor = Visibility.TeamColor(esp, data, "highlight")
	local highlightFillTransparency = 1 - (1 - Visibility.TeamTransparency(esp, data, "highlight")) * (1 - ft)

	local state = {
		min = position,
		size = size,
		healthRatio = healthRatio,
		healthValue = healthValue,
		displayHealthRatio = displayHealthRatio,
		distance = distance,
		nameText = formatText(nameText),
		toolText = toolText,
		distanceEnabled = features["distance"],
		boxColor = boxColor,
		boxTransparency = boxTransparency,
		boxFillColor = boxFillColor,
		boxFillTransparency = boxFillTransparency,
		nameColor = nameColor,
		nameTransparency = nameTransparency,
		healthColor = healthColor,
		healthTransparency = healthTransparency,
		healthTextColor = healthTextColor,
		healthTextTransparency = healthTextTransparency,
		hideFullHealth = esp.HideFullHealthText,
		distanceColor = distanceColor,
		distanceTransparency = distanceTransparency,
		toolTextColor = toolTextColor,
		toolTextTransparency = toolTextTransparency,
		highlightFillColor = highlightFillColor,
		highlightFillTransparency = highlightFillTransparency,
		highlightOutlineColor = esp.HighlightOutlineColor,
		highlightOutlineTransparency = esp.HighlightOutlineTransparency,
		highlightBehindWalls = esp.HighlightBehindWalls,
		healthBarGap = esp.HealthBarGap,
		healthBarWidth = esp.HealthBarWidth,
		healthBarOutline = esp.HealthBarOutline,
		healthBarYOffset = esp.HealthBarYOffset,
		healthBarGradientDirection = esp.HealthBarGradientDirection,
		visible = true,
		character = character,
	}

	for _, entry in DISPATCH do
		local enabled = false
		for _, k in entry.keys do
			if features[k] then enabled = true; break end
		end
		if enabled then
			entry.mod.ensure(data, screenGui)
			entry.mod.update(data, data, state)
		else
			entry.mod.update(data, data, nil)
		end
	end

	data.lastState = {
		min = position,
		size = size,
		nameText = nameText,
		toolText = toolText,
		healthRatio = healthRatio,
		displayHealthRatio = displayHealthRatio,
		distance = distance,
		distanceEnabled = features["distance"],
	}
end

local function stop()
	if renderConnection then
		renderConnection:Disconnect()
		renderConnection = nil
	end
	for _, data in pairs(playerData) do
		hideAllFeatures(data)
	end
end

local function updateAll()
	if not esp.Enabled or not Visibility.HasAnyEnabledFeature(esp) then
		stop()
		return
	end

	if esp.LimitFPS > 0 then
		local now = tick()
		if now - lastRender < (1 / esp.LimitFPS) then return end
		lastRender = now
	end

	camera = Services.Workspace.CurrentCamera
	local localCharacter = Utility.GetCharacter(localPlayer)

	for _, data in pairs(playerData) do
		if data and data.features and data.features.any then
			updatePlayerGui(data)
		elseif data then
			hideAllFeatures(data)
		end
	end
end

local addPlayerGui

local function start()
	if renderConnection then return end
	if not esp.Enabled or not Visibility.HasAnyEnabledFeature(esp) then return end

	renderConnection = RunService.RenderStepped:Connect(updateAll)

	for _, player in Players:GetPlayers() do
		if not playerData[player] then
			addPlayerGui(player)
		end
	end
end

addPlayerGui = function(player: Player)
	if playerData[player] then return end

	local root = Element("Frame", {
		Parent = screenGui,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(0, 0),
		Visible = true,
	})

	local data: PlayerGuiData = {
		player = player,
		root = root,
		features = {},
		displayedHealthRatio = 1,
		connections = {},
		characterConns = {},
		character = nil,
		humanoid = nil,
		rootPart = nil,
		health = 100,
		maxHealth = 100,
		teamState = "neutral",
		teamColor = nil,
		tool = nil,
		bodyParts = nil,
		fadeTransparency = 1,
		leaving = false,
		lastState = nil,
	}

	local function updateTeamState()
		if player == Players.LocalPlayer then
			data.teamState = "local"
		elseif player.Team and player.Team ~= Players.LocalPlayer.Team then
			data.teamState = "enemy"
		elseif player.Team and player.Team == Players.LocalPlayer.Team then
			data.teamState = "friendly"
		else
			data.teamState = "neutral"
		end
		data.teamColor = player.Team and player.Team.TeamColor.Color or nil
		data.features = Visibility.ComputeFeatures(esp, data)
	end
	updateTeamState()

	table.insert(data.connections, player:GetPropertyChangedSignal("Team"):Connect(updateTeamState))
	table.insert(data.connections, player.CharacterAdded:Connect(function(character: Model)
		clearCharacter(data)
		setupCharacter(data, character)
		start()
	end))
	table.insert(data.connections, player.CharacterRemoving:Connect(function()
		clearCharacter(data)
	end))

	if player.Character then
		setupCharacter(data, player.Character)
		if esp.Enabled then
			start()
		end
	end

	data.features = Visibility.ComputeFeatures(esp, data)

	playerData[player] = data

	if data.features.any then
		start()
	end
end

local function reconcileAll(): boolean
	if not esp.Enabled or not Visibility.HasAnyEnabledFeature(esp) then
		for _, data in pairs(playerData) do
			destroyPlayerGui(data)
		end
		return false
	end

	for _, player in Players:GetPlayers() do
		if not playerData[player] then
			addPlayerGui(player)
		end
	end

	local hasRenderable = false
	for _, data in pairs(playerData) do
		local features = Visibility.ComputeFeatures(esp, data)
		data.features = features
		if features.any then
			hasRenderable = true
		end
	end

	return hasRenderable
end

local function queueReconcile()
	if reconcileQueued then return end
	reconcileQueued = true
	task.defer(function()
		reconcileQueued = false
		if reconcileAll() then
			start()
		else
			stop()
		end
	end)
end

Players.PlayerAdded:Connect(addPlayerGui)
for _, player in Players:GetPlayers() do
	addPlayerGui(player)
end
Players.PlayerRemoving:Connect(function(player: Player)
	local data = playerData[player]
	if data then
		if data.lastState then
			data.leaving = true
		else
			destroyPlayerGui(data)
		end
	end
end)

esp.Changed:Connect(function()
	queueReconcile()
end)

Fonts.OnLoaded(function()
	queueReconcile()
end)

local bindings = {}
setmetatable(bindings, {
	__index = function(_, k) return esp[k] end,
	__newindex = function(_, k, v) esp[k] = v; esp.Changed:Fire() end,
})

return {
	esp = esp,
	playerData = playerData,
	bindings = bindings,
	queueReconcile = queueReconcile,
	start = start,
	stop = stop,
}
