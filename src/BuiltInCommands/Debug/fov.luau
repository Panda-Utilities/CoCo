--!strict
local Services = require("../../Shared/Services")
local RunService = Services.RunService

local fovConnection = nil

return {
	Name = "fov";
	Aliases = {};
	Description = "Set a custom FOV. Resets when toggled off.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "value";
			Description = "FOV value (e.g. 120) or blank to toggle off";
			Optional = true;
		};
	};

	ClientRun = function(_, value)
		if not value or value <= 0 then
			if fovConnection then
				fovConnection:Disconnect()
				fovConnection = nil
			end
			return "FOV override disabled."
		end

		if fovConnection then
			fovConnection:Disconnect()
		end

		fovConnection = RunService.RenderStepped:Connect(function()
			local camera = workspace.CurrentCamera
			if camera then
				camera.FieldOfView = value
			end
		end)

		return ("FOV set to %d."):format(value)
	end;
}
