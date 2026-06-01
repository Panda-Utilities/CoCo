--!strict
local Services = require("../../Shared/Services")
local Players = Services.Players

local viewingPart = nil
local viewPartDied = nil

return {
	Name = "viewpart";
	Aliases = {"viewp"};
	Description = "Spectate a part by its name.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "string";
			Name = "partName";
			Description = "Name of the part to spectate";
			Optional = true;
		};
	};

	ClientRun = function(_, partName)
		if viewingPart or not partName then
			if viewPartDied then
				viewPartDied:Disconnect()
				viewPartDied = nil
			end

			local cam = workspace.CurrentCamera
			local player = Players.LocalPlayer
			local char = player.Character
			if char then
				local humanoid = char:FindFirstChildWhichIsA("Humanoid")
				if humanoid then
					cam.CameraSubject = humanoid
				end
			end
			cam.CameraType = Enum.CameraType.Custom

			viewingPart = nil
			return "Part spectate stopped."
		end

		local parts = {}
		for _, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") and v.Name:lower() == partName:lower() then
				table.insert(parts, v)
			end
		end

		if #parts == 0 then
			return ("No part named %q found."):format(partName)
		end

		local target = parts[1]
		if #parts > 1 then
			local cam = workspace.CurrentCamera
			local camPos = cam.CFrame.p
			local closest = parts[1]
			local closestDist = (closest.Position - camPos).Magnitude
			for i = 2, #parts do
				local dist = (parts[i].Position - camPos).Magnitude
				if dist < closestDist then
					closest = parts[i]
					closestDist = dist
				end
			end
			target = closest
		end

		viewingPart = target

		local cam = workspace.CurrentCamera
		cam.CameraType = Enum.CameraType.Attach
		cam.CameraSubject = target

		if viewPartDied then viewPartDied:Disconnect() end
		viewPartDied = target.AncestryChanged:Connect(function()
			if not target.Parent then
				local player = Players.LocalPlayer
				local char = player.Character
				if char then
					local humanoid = char:FindFirstChildWhichIsA("Humanoid")
					if humanoid then
						cam.CameraSubject = humanoid
					end
				end
				cam.CameraType = Enum.CameraType.Custom
				viewingPart = nil
				viewPartDied = nil
			end
		end)

		return ("Now spectating %s."):format(target:GetFullName())
	end;
}
