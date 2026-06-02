local Services = require("../../Shared/Services")
local Players = Services.Players

local hitboxActive = false
local savedStates = {}
local playerConnections = {}

local function clearHitbox()
	for player, state in pairs(savedStates) do
		local char = player.Character
		if char then
			local humanoid = char:FindFirstChildWhichIsA("Humanoid")
			if humanoid and humanoid.RootPart then
				humanoid.RootPart.Size = state.origSize
				humanoid.RootPart.CanCollide = state.origCanCollide
				humanoid.RootPart.Transparency = state.origTransparency
			end
		end
	end
	table.clear(savedStates)

	for _, conns in pairs(playerConnections) do
		for _, conn in ipairs(conns) do
			pcall(function() conn:Disconnect() end)
		end
	end
	table.clear(playerConnections)

	hitboxActive = false
end

local function applyHitboxToPlayer(plr, size, transparency)
	if plr == Players.LocalPlayer then return end

	local state = savedStates[plr]
	if state then
		local char = plr.Character
		if char then
			local humanoid = char:FindFirstChildWhichIsA("Humanoid")
			if humanoid and humanoid.RootPart then
				humanoid.RootPart.Size = state.origSize
				humanoid.RootPart.CanCollide = state.origCanCollide
				humanoid.RootPart.Transparency = state.origTransparency
			end
		end
	end

	local char = plr.Character
	if not char then return end
	local humanoid = char:FindFirstChildWhichIsA("Humanoid")
	if not humanoid then return end
	local root = humanoid.RootPart
	if not root then return end

	savedStates[plr] = {
		origSize = root.Size;
		origCanCollide = root.CanCollide;
		origTransparency = root.Transparency;
	}

	root.Size = Vector3.new(size, size, size)
	root.CanCollide = false
	root.Transparency = transparency
end

local function setupPlayerTracking(plr, size, transparency)
	local conns = {}
	playerConnections[plr] = conns

	table.insert(conns, plr.CharacterAdded:Connect(function()
		task.wait(0.3)
		if hitboxActive then
			applyHitboxToPlayer(plr, size, transparency)
		end
	end))

	if plr.Character then
		applyHitboxToPlayer(plr, size, transparency)
	end
end

return {
	Name = "hitbox";
	Aliases = {};
	InverseAliases = {"unhitbox", "nohitbox"};
	Description = "Scale all players' HumanoidRootPart hitbox. Usage: hitbox [size] [transparency]";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "size";
			Description = "Hitbox size (default: 2, max: 50)";
			Default = 2;
			Optional = true;
		};
		{
			Type = "number";
			Name = "transparency";
			Description = "Root part transparency (default: 0.9)";
			Default = 0.9;
			Optional = true;
		};
	};

	ClientRun = function(context, size, transparency)
		if context:isInvertedCall() then
			if not hitboxActive then return "Hitbox already disabled." end
			clearHitbox()
			return "Hitbox disabled."
		end

		if hitboxActive then
			clearHitbox()
			task.wait()
		end

		size = math.clamp(size, 1, 50)
		transparency = math.clamp(transparency, 0, 1)
		hitboxActive = true

		for _, plr in ipairs(Players:GetPlayers()) do
			if not playerConnections[plr] then
				setupPlayerTracking(plr, size, transparency)
			else
				applyHitboxToPlayer(plr, size, transparency)
			end
		end

		if not playerConnections.PlayerAdded then
			local paConn = Players.PlayerAdded:Connect(function(plr)
				setupPlayerTracking(plr, size, transparency)
			end)
			playerConnections.PlayerAdded = {paConn}
		end

		if not playerConnections.PlayerRemoving then
			local prConn = Players.PlayerRemoving:Connect(function(plr)
				savedStates[plr] = nil
				playerConnections[plr] = nil
			end)
			playerConnections.PlayerRemoving = {prConn}
		end

		return ("Hitbox enabled for all players (size=%g, transparency=%g)."):format(size, transparency)
	end;
}
