return {
	Name = "trip";
	Aliases = {};
	Description = "Make your character trip.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		local root = humanoid and humanoid.RootPart
		if not humanoid or not root then return "No humanoid or root part." end

		humanoid:ChangeState(Enum.HumanoidStateType.FallingDown)
		root.Velocity = root.CFrame.LookVector * 30

		return "Tripped."
	end;
}
