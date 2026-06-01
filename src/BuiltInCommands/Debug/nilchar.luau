return {
	Name = "nilchar";
	Aliases = {};
	Description = "Despawn your character without triggering respawn.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if humanoid then
			humanoid:Destroy()
		end

		character:Destroy()
		return "Character nil'd."
	end;
}
