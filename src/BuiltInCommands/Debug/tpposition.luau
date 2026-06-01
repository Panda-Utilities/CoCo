return {
	Name = "tpposition";
	Aliases = {"tppos"};
	Description = "Teleport to X Y Z coordinates.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "x";
			Description = "X coordinate";
		};
		{
			Type = "number";
			Name = "y";
			Description = "Y coordinate";
		};
		{
			Type = "number";
			Name = "z";
			Description = "Z coordinate";
		};
	};

	ClientRun = function(context, x, y, z)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local root = humanoid.RootPart
		if not root then return "No root part." end

		root.CFrame = CFrame.new(x, y, z)
		return ("Teleported to (%.0f, %.0f, %.0f)."):format(x, y, z)
	end;
}
