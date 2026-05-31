--!strict
local Services = require("../Shared/Services")
local Window = require("./CoCoInterface/Window")

return function(CoCo, gui)
	CoCo.Events.Message:Connect(function(text)
		local success = pcall(function()
			Services.StarterGui:SetCore("ChatMakeSystemMessage", {
				Text = ("[Announcement] %s"):format(text),
				Color = Color3.fromRGB(249, 217, 56),
			})
		end)

		if not success then
			warn("CoCo: Failed to send chat announcement message.")
		end
	end)

	CoCo.Events.AddLine:Connect(function(...)
		Window:addLine(...)
	end)
end
