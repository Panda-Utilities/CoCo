return {
	Name = "jump";
	Aliases = {};
	Description = "Force your character to jump.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		return "Jumped."
	end;
}
