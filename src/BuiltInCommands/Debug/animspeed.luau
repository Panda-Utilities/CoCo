--!strict
return {
	Name = "animspeed";
	Aliases = {};
	Description = "Adjust playback speed of all playing animations.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "speed";
			Description = "Speed multiplier (0.1-10)";
			Default = 1;
		};
	};

	ClientRun = function(context, speed)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		speed = math.clamp(speed, 0.1, 10)
		local adjusted = 0

		for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
			track:AdjustSpeed(speed)
			adjusted = adjusted + 1
		end

		return ("Adjusted speed of %d animation(s) to %g."):format(adjusted, speed)
	end;
}
