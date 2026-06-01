return {
	Name = "headthrow";
	Aliases = {};
	Description = "Launch your character's head as a physics projectile.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local head = character:FindFirstChild("Head")
		if not head then return "No head found." end

		local cam = workspace.CurrentCamera
		local direction = cam.CFrame.LookVector * 200

		head.Velocity = direction
		head:BreakJoints()

		return "Head thrown."
	end;
}
