return {
	Name = "fakeout";
	Aliases = {};
	Description = "Teleport to the void and back (detaches players sitting on you).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid." end

		local root = humanoid.RootPart
		if not root then return "No root part." end

		local oldPos = root.CFrame
		local height = workspace.FallenPartsDestroyHeight
		if height == -math.huge then height = -500 end

		root.CFrame = CFrame.new(0, height - 25, 0)
		task.wait(1)
		root.CFrame = oldPos

		return "Fakeout complete."
	end;
}
