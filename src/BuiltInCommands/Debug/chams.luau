local Services = require("../../Shared/Services")
local Players = Services.Players
local CoreGui = Services.CoreGui

local chamsActive = false
local playerConnections = {}
local localPlayer = Players.LocalPlayer

local function clearChams()
	for _, conns in pairs(playerConnections) do
		for _, conn in ipairs(conns) do
			pcall(function() conn:Disconnect() end)
		end
	end
	table.clear(playerConnections)

	for _, v in ipairs(CoreGui:GetChildren()) do
		if v.Name:find("_CHMS$") then
			v:Destroy()
		end
	end

	chamsActive = false
end

local function holderForPlayer(plr)
	for _, v in ipairs(CoreGui:GetChildren()) do
		if v.Name == plr.Name .. "_CHMS" then
			return v
		end
	end
	return nil
end

local function applyChamsToPlayer(plr)
	if plr == localPlayer then return end
	if not plr.Character then return end

	local holder = holderForPlayer(plr)
	if not holder then
		holder = Instance.new("Folder")
		holder.Name = plr.Name .. "_CHMS"
		holder.Parent = CoreGui
	end

	for _, descendant in ipairs(plr.Character:GetDescendants()) do
		if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" then
			local adorn = Instance.new("BoxHandleAdornment")
			adorn.Name = plr.Name
			adorn.Adornee = descendant
			adorn.AlwaysOnTop = true
			adorn.ZIndex = 10
			adorn.Size = descendant.Size
			adorn.Transparency = 0.3
			adorn.Color = plr.TeamColor
			adorn.Parent = holder
		end
	end
end

local function setupPlayerTracking(plr)
	local conns = {}
	playerConnections[plr] = conns

	local function onCharacter()
		local existing = holderForPlayer(plr)
		if existing then existing:Destroy() end
		if chamsActive then
			task.wait(0.3)
			applyChamsToPlayer(plr)
		end
	end

	table.insert(conns, plr.CharacterAdded:Connect(onCharacter))
	table.insert(conns, plr:GetPropertyChangedSignal("TeamColor"):Connect(function()
		if chamsActive then
			local holder = holderForPlayer(plr)
			if holder then
				for _, v in ipairs(holder:GetChildren()) do
					if v:IsA("BoxHandleAdornment") then
						v.Color = plr.TeamColor
					end
				end
			end
		end
	end))

	if plr.Character then
		applyChamsToPlayer(plr)
	end
end

return {
	Name = "chams";
	Aliases = {};
	InverseAliases = {"unchams", "nochams"};
	Description = "Toggle chams (BoxHandleAdornment overlay on all players).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not chamsActive then return "Chams already disabled." end
			clearChams()
			return "Chams disabled."
		end

		if chamsActive then
			clearChams()
			task.wait()
		end

		chamsActive = true

		for _, plr in ipairs(Players:GetPlayers()) do
			if not playerConnections[plr] then
				setupPlayerTracking(plr)
			else
				applyChamsToPlayer(plr)
			end
		end

		if not playerConnections.PlayerAdded then
			local paConn = Players.PlayerAdded:Connect(function(plr)
				setupPlayerTracking(plr)
			end)
			playerConnections.PlayerAdded = {paConn}
		end

		if not playerConnections.PlayerRemoving then
			local prConn = Players.PlayerRemoving:Connect(function(plr)
				local holder = holderForPlayer(plr)
				if holder then holder:Destroy() end
				playerConnections[plr] = nil
			end)
			playerConnections.PlayerRemoving = {prConn}
		end

		return "Chams enabled."
	end;
}
