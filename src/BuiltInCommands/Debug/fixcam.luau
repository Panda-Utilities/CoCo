return {
	Name = "fixcam";
	Aliases = {"restorecam"};
	Description = "Reset the camera to default state.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local cam = workspace.CurrentCamera
		local char = context.Executor.Character
		if char then
			local humanoid = char:FindFirstChildWhichIsA("Humanoid")
			if humanoid then
				cam.CameraSubject = humanoid
			end
		end

		cam.CameraType = Enum.CameraType.Custom
		context.Executor.CameraMinZoomDistance = 0.5
		context.Executor.CameraMaxZoomDistance = 400

		return "Camera reset."
	end;
}
