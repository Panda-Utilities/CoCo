--!strict
return {
	Name = "hipheight";
	Aliases = {"hheight"};
	Description = "Set your character's HipHeight. Usage: hipheight <number>";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "height";
			Description = "HipHeight value";
		};
	};

	ClientRun = function(context, height)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		humanoid.HipHeight = height
		return ("HipHeight set to %s."):format(tostring(height))
	end;
}
