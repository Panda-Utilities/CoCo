--!strict
return {
	Name = "spawnpoint";
	Aliases = {"spawn"};
	Description = "Set a custom spawn point at your position. Run again to clear.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local root = humanoid.RootPart
		if not root then return "No root part." end

		local existing = character:FindFirstChild("CustomSpawn")
		if existing then
			existing:Destroy()
			return "Custom spawn point cleared."
		end

		local spawnVal = Instance.new("CFrameValue")
		spawnVal.Name = "CustomSpawn"
		spawnVal.Value = root.CFrame
		spawnVal.Parent = character

		context.Executor.CharacterAdded:Connect(function(newChar)
			local sp = newChar:FindFirstChild("CustomSpawn")
			if not sp then return end
			task.wait(0.2)
			local newRoot = newChar:FindFirstChildWhichIsA("Humanoid")
			newRoot = newRoot and newRoot.RootPart
			if newRoot then
				newRoot.CFrame = sp.Value
			end
		end)

		return "Custom spawn point set."
	end;
}
