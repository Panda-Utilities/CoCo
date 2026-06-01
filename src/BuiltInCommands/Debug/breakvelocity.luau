return {
	Name = "breakvelocity";
	Aliases = {};
	Description = "Stop all momentum on your character.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
		local root = humanoid and humanoid.RootPart
		if not root then return "No root part found." end

		root.Velocity = Vector3.zero
		root.RotVelocity = Vector3.zero

		return "Velocity broken."
	end;
}
