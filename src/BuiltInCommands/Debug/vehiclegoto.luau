return {
	Name = "vehiclegoto";
	Aliases = {"vgoto", "vtp"};
	Description = "Teleport to a player's vehicle seat.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player whose vehicle to teleport to";
		};
	};

	ClientRun = function(context, target)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local root = humanoid.RootPart
		if not root then return "No root part." end

		local tChar = target.Character
		if not tChar then return "Target has no character." end

		local seat = nil
		for _, v in ipairs(tChar:GetDescendants()) do
			if v:IsA("VehicleSeat") then
				seat = v
				break
			end
		end

		if not seat then
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("VehicleSeat") then
					local occupant = v:FindFirstChild("Occupant")
					if occupant and occupant.Value and occupant.Value.Parent == tChar then
						seat = v
						break
					end
				end
			end
		end

		if not seat then
			if tChar:FindFirstChildWhichIsA("Humanoid") then
				local tHum = tChar:FindFirstChildWhichIsA("Humanoid")
				local tRoot = tHum.RootPart
				if tRoot then
					root.CFrame = tRoot.CFrame * CFrame.new(5, 0, 0)
					return ("Teleported near %s."):format(target.Name)
				end
			end
			return "No vehicle seat found."
		end

		root.CFrame = seat.CFrame * CFrame.new(0, 3, 0)
		return ("Teleported to %s's vehicle."):format(target.Name)
	end;
}
