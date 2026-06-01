return {
	Name = "headsit";
	Aliases = {};
	Description = "Sit on a player's head.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to sit on";
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

		local tHead = tChar:FindFirstChild("Head")
		if not tHead then return "Target has no head." end

		root.CFrame = tHead.CFrame * CFrame.new(0, 2, 0)
		humanoid.Sit = true

		return ("Sitting on %s's head."):format(target.Name)
	end;
}
