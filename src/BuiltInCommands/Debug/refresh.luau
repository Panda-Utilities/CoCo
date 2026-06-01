--!strict
return {
	Name = "refresh";
	Aliases = {"re"};
	Description = "Refresh your character (respawn & restore position).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		local rootPart = humanoid and humanoid.RootPart
		local pos = rootPart and rootPart.CFrame
		local camPos = workspace.CurrentCamera.CFrame

		if humanoid then
			humanoid:ChangeState(Enum.HumanoidStateType.Dead)
		end
		character:ClearAllChildren()

		local newChar = Instance.new("Model")
		newChar.Parent = workspace
		context.Executor.Character = newChar
		task.wait()
		context.Executor.Character = character
		newChar:Destroy()

		task.spawn(function()
			local char = context.Executor.CharacterAdded:Wait()
			local hum = char:FindFirstChildWhichIsA("Humanoid")
			while not hum do
				task.wait()
				hum = char:FindFirstChildWhichIsA("Humanoid")
			end
			if pos then
				local newRoot = hum.RootPart
				if newRoot then
					newRoot.CFrame = pos
				end
			end
			workspace.CurrentCamera.CFrame = camPos
		end)

		return "Refreshed."
	end;
}
