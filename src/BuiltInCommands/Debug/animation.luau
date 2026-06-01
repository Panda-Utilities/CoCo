--!strict
return {
	Name = "animation";
	Aliases = {"anim"};
	Description = "Play an animation by ID.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "string";
			Name = "id";
			Description = "Animation ID (number)";
		};
		{
			Type = "number";
			Name = "speed";
			Description = "Playback speed (optional)";
			Optional = true;
		};
	};

	ClientRun = function(context, id, speed)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local animId = id:match("(%d+)")
		if not animId then return "Invalid animation ID." end

		local animation = Instance.new("Animation")
		animation.AnimationId = "rbxassetid://" .. animId

		local track = humanoid:LoadAnimation(animation)
		track.Priority = Enum.AnimationPriority.Movement
		track:Play()

		if speed then
			track:AdjustSpeed(math.clamp(speed, 0.1, 10))
		end

		return ("Playing animation %s."):format(animId)
	end;
}
