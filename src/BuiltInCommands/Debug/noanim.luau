--!strict

return {
	Name = "noanim";
	Aliases = {};
	Description = "Toggle disabling all character animations.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local animate = character:FindFirstChild("Animate")
		if not animate then return "No Animate script found." end

		animate.Disabled = not animate.Disabled
		return animate.Disabled and "Animations disabled." or "Animations enabled."
	end;
}
