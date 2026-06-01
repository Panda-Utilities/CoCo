return {
	Name = "walkspeed";
	Aliases = {"ws", "speed"};
	Description = "Set your walkspeed.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "speed";
			Description = "The walkspeed to set (default: 16)";
			Default = 16;
		};
	};

	ClientRun = function(context, speed)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		humanoid.WalkSpeed = speed
		return ("Walkspeed set to %d."):format(speed)
	end;
}
