--!strict
return {
	Name = "stopanimations";
	Aliases = {"stopanims", "stopanim"};
	Description = "Stop all playing animations.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local stopped = 0
		for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
			track:Stop()
			stopped = stopped + 1
		end

		return ("Stopped %d animation(s)."):format(stopped)
	end;
}
