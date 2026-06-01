return {
	Name = "thirdp";
	Aliases = {};
	Description = "Force third-person camera.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local cam = workspace.CurrentCamera
		local char = context.Executor.Character

		cam.CameraType = Enum.CameraType.Custom

		if char then
			local humanoid = char:FindFirstChildWhichIsA("Humanoid")
			if humanoid then
				cam.CameraSubject = humanoid
			end
		end

		context.Executor.CameraMode = Enum.CameraMode.Classic
		return "Third-person enabled."
	end;
}
