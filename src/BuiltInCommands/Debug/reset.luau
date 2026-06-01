return {
	Name = "reset";
	Aliases = {"respawn"};
	Description = "Reset your character (kill).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Dead)
		else
			character:BreakJoints()
		end

		return "Reset."
	end;
}
