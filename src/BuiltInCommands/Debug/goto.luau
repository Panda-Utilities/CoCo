--!strict
return {
	Name = "goto";
	Aliases = {"to", "tp"};
	Description = "Teleport to a player.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to teleport to";
		};
	};

	ClientRun = function(context, target)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local targetChar = target.Character
		if not targetChar then return "Target has no character." end

		local targetRoot = targetChar:FindFirstChildWhichIsA("Humanoid")
		if not targetRoot then return "Target has no humanoid." end

		local targetRootPart = targetRoot.RootPart
		if not targetRootPart then return "Target has no root part." end

		local myRoot = humanoid.RootPart
		if not myRoot then return "You have no root part." end

		if humanoid.SeatPart then
			humanoid.Sit = false
			task.wait(0.1)
		end

		myRoot.CFrame = targetRootPart.CFrame * CFrame.new(3, 1, 0)

		return ("Teleported to %s."):format(target.Name)
	end;
}
