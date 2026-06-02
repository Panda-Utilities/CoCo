local locateMarkers = {}

local function createBeacon(targetPlayer)
	local character = targetPlayer.Character
	if not character then return nil end

	local humanoid = character:FindFirstChildWhichIsA("Humanoid")
	local rootPart = humanoid and humanoid.RootPart
	if not rootPart then return nil end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "CoCoLocate"
	billboard.AlwaysOnTop = true
	billboard.Size = UDim2.new(0, 60, 0, 60)
	billboard.StudsOffset = Vector3.new(0, 4, 0)
	billboard.Adornee = rootPart

	local arrow = Instance.new("TextLabel")
	arrow.Size = UDim2.new(1, 0, 1, 0)
	arrow.BackgroundTransparency = 1
	arrow.Text = "▼"
	arrow.TextColor3 = Color3.new(0, 1, 0)
	arrow.TextSize = 40
	arrow.Font = Enum.Font.Code
	arrow.Parent = billboard

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, 0, 0, 20)
	nameLabel.Position = UDim2.new(0, 0, 1, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = targetPlayer.Name
	nameLabel.TextColor3 = Color3.new(1, 1, 1)
	nameLabel.TextSize = 14
	nameLabel.Font = Enum.Font.Code
	nameLabel.TextStrokeTransparency = 0.5
	nameLabel.Parent = billboard

	billboard.Parent = rootPart
	return billboard
end

return {
	Name = "locate";
	Aliases = {};
	InverseAliases = {"unlocate", "nolocate"};
	Description = "Place a visible beacon above a player.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to locate";
		};
	};

	ClientRun = function(context, target)
		if context:isInvertedCall() then
			local marker = locateMarkers[target]
			if not marker then return ("No beacon for %s."):format(target.Name) end
			pcall(function() marker:Destroy() end)
			locateMarkers[target] = nil
			return ("Beacon removed from %s."):format(target.Name)
		end

		local existing = locateMarkers[target]
		if existing then
			pcall(function() existing:Destroy() end)
		end

		local beacon = createBeacon(target)
		if not beacon then
			return ("%s has no character."):format(target.Name)
		end

		locateMarkers[target] = beacon
		return ("Beacon placed on %s."):format(target.Name)
	end;
}
