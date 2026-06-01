local Services = require("../../Shared/Services")
local Players = Services.Players

local viewing = nil
local viewDied = nil
local viewChanged = nil

local function stopView(context)
	if viewDied then
		viewDied:Disconnect()
		viewDied = nil
	end
	if viewChanged then
		viewChanged:Disconnect()
		viewChanged = nil
	end

	local cam = workspace.CurrentCamera
	local char = context.Executor.Character
	if char then
		local humanoid = char:FindFirstChildWhichIsA("Humanoid")
		if humanoid then
			cam.CameraSubject = humanoid
		end
	end
	cam.CameraType = Enum.CameraType.Custom

	viewing = nil
end

return {
	Name = "view";
	Aliases = {"spectate"};
	InverseAliases = {"unview", "unspectate"};
	Description = "Toggle spectate a player (see through their eyes).";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to spectate";
			Optional = true;
		};
	};

	ClientRun = function(context, target)
		if context:isInvertedCall() then
			if not viewing then return "Not spectating anyone." end
			stopView(context)
			return "Spectate stopped."
		end

		if not target or viewing then
			stopView(context)
			return "Spectate stopped."
		end

		local targetChar = target.Character
		if not targetChar then return "Target has no character." end

		viewing = target

		local cam = workspace.CurrentCamera
		cam.CameraSubject = targetChar

		if viewDied then viewDied:Disconnect() end
		if viewChanged then viewChanged:Disconnect() end

		viewDied = target.CharacterAdded:Connect(function()
			repeat task.wait() until target.Character and target.Character:FindFirstChildWhichIsA("Humanoid")
			local c = target.Character:FindFirstChildWhichIsA("Humanoid")
			if c then cam.CameraSubject = c end
		end)

		viewChanged = cam:GetPropertyChangedSignal("CameraSubject"):Connect(function()
			if viewing and viewing.Character then
				local h = viewing.Character:FindFirstChildWhichIsA("Humanoid")
				if h then cam.CameraSubject = h end
			end
		end)

		return ("Now spectating %s."):format(target.Name)
	end;
}
