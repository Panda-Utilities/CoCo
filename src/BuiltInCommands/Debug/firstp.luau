--!strict
return {
	Name = "firstp";
	Aliases = {};
	Description = "Force first-person camera.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local cam = workspace.CurrentCamera
		local char = context.Executor.Character

		cam.CameraType = Enum.CameraType.Fixed

		if char then
			local head = char:FindFirstChild("Head")
			if head then
				cam.CFrame = CFrame.new(head.Position)
			end
		end

		context.Executor.CameraMode = Enum.CameraMode.LockFirstPerson
		return "First-person enabled."
	end;
}
