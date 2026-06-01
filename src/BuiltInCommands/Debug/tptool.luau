local Services = require("../../Shared/Services")
local UserInputService = Services.UserInputService

return {
	Name = "tptool";
	Aliases = {"teleporttool"};
	Description = "Give yourself a teleport tool.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local player = context.Executor
		local backpack = player:FindFirstChildWhichIsA("Backpack")
		if not backpack then return "No backpack found." end

		local tool = Instance.new("Tool")
		tool.Name = "Teleport Tool"
		tool.RequiresHandle = false
		tool.Parent = backpack

		tool.Activated:Connect(function()
			local character = player.Character
			local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
			local root = humanoid and humanoid.RootPart
			if not root then return end

			local cam = workspace.CurrentCamera
			local mousePos = UserInputService:GetMouseLocation()
			local unitRay = cam:ViewportPointToRay(mousePos.X, mousePos.Y)
			local result = workspace:Raycast(unitRay.Origin, unitRay.Direction * 1000)
			local pos = result and result.Position or unitRay.Origin + unitRay.Direction * 1000

			root.CFrame = CFrame.new(pos.X, pos.Y + 3, pos.Z) * CFrame.fromOrientation(root.CFrame:ToOrientation())
			root.Velocity = Vector3.zero
			root.RotVelocity = Vector3.zero
		end)

		return "Teleport tool given."
	end;
}
