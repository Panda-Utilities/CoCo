return {
	Name = "offset";
	Aliases = {};
	Description = "Teleport with offset from a player.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to offset from";
		};
		{
			Type = "number";
			Name = "x";
			Description = "X offset";
			Default = 5;
		};
		{
			Type = "number";
			Name = "y";
			Description = "Y offset";
			Default = 0;
		};
		{
			Type = "number";
			Name = "z";
			Description = "Z offset";
			Default = 0;
		};
	};

	ClientRun = function(context, target, x, y, z)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local root = humanoid.RootPart
		if not root then return "No root part." end

		local tChar = target.Character
		if not tChar then return "Target has no character." end

		local tHum = tChar:FindFirstChildWhichIsA("Humanoid")
		if not tHum then return "Target has no humanoid." end

		local tRoot = tHum.RootPart
		if not tRoot then return "Target has no root part." end

		root.CFrame = tRoot.CFrame * CFrame.new(x, y, z)
		return ("Teleported with offset (%g, %g, %g) from %s."):format(x, y, z, target.Name)
	end;
}
