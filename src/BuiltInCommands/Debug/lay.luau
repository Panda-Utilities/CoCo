--!strict
return {
	Name = "lay";
	Aliases = {"laydown"};
	Description = "Lay your character down.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		humanoid.Sit = true
		task.wait(0.1)

		local rootPart = humanoid.RootPart
		if rootPart then
			rootPart.CFrame = rootPart.CFrame * CFrame.Angles(math.pi * 0.5, 0, 0)
		end

		for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
			track:Stop()
		end

		return "Lay enabled."
	end;
}
