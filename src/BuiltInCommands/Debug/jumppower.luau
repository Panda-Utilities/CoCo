--!strict
return {
	Name = "jumppower";
	Aliases = {"jp", "jpower"};
	Description = "Set your jump power or jump height.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "power";
			Description = "The jump power/height to set (default: 50)";
			Default = 50;
		};
	};

	ClientRun = function(context, power)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		if humanoid.UseJumpPower then
			humanoid.JumpPower = power
		else
			humanoid.JumpHeight = power
		end

		return ("Jump power set to %d."):format(power)
	end;
}
