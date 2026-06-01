local Services = require("../../Shared/Services")
local VirtualUser = game:GetService("VirtualUser")

local antiafkRunning = false
local antiafkConnection = nil

return {
	Name = "antiafk";
	Aliases = {"antiidle"};
	Description = "Toggle anti-AFK (prevents being kicked for idling).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if antiafkRunning then
			if antiafkConnection then
				antiafkConnection:Disconnect()
				antiafkConnection = nil
			end
			antiafkRunning = false
			return "Anti-AFK disabled."
		end

		if getconnections then
			for _, connection in ipairs(getconnections(context.Executor.Idled)) do
				if connection.Disable then
					connection:Disable()
				elseif connection.Disconnect then
					connection:Disconnect()
				end
			end
		else
			antiafkConnection = context.Executor.Idled:Connect(function()
				VirtualUser:CaptureController()
				VirtualUser:ClickButton2(Vector2.new())
			end)
		end

		antiafkRunning = true
		return "Anti-AFK enabled."
	end;
}
