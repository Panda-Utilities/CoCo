return {
	Name = "stun";
	Aliases = {"platformstand"};
	InverseAliases = {"unstun", "nostun"};
	Description = "Toggle stun (platform stand).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		if context:isInvertedCall() then
			if not humanoid.PlatformStand then return "Already unstunned." end
			humanoid.PlatformStand = false
			return "Unstunned."
		end

		humanoid.PlatformStand = not humanoid.PlatformStand
		return humanoid.PlatformStand and "Stunned." or "Unstunned."
	end;
}
