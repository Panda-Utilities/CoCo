--!strict
local Services = require("../../Shared/Services")
local Lighting = Services.Lighting
local ReplicatedStorage = game:GetService("ReplicatedStorage")

return {
	Name = "tools";
	Aliases = {"gears"};
	Description = "Copy tools from Lighting and ReplicatedStorage into your backpack.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local backpack = context.Executor:FindFirstChildWhichIsA("Backpack")
		if not backpack then return "No backpack found." end

		local count = 0

		local function copyFrom(instance)
			for _, child in ipairs(instance:GetChildren()) do
				if child:IsA("Tool") or child:IsA("HopperBin") then
					child:Clone().Parent = backpack
					count = count + 1
				end
				copyFrom(child)
			end
		end

		copyFrom(Lighting)
		copyFrom(ReplicatedStorage)

		return ("Copied %d tools from Lighting and ReplicatedStorage."):format(count)
	end;
}
