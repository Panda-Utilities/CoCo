--!strict
if getgenv().CoCo then return end
getgenv().CoCo = true

local CoCo = require("./init")

local gui = pcall(gethui) and gethui()
local guiInstance = gui and gui:FindFirstChild("CoCo")
if not guiInstance then
	local t = os.clock()
	while not guiInstance and os.clock() - t < 5 do
		guiInstance = gui and gui:FindFirstChild("CoCo")
		task.wait()
	end
end

local _ = require("./CoCoClient/init")(CoCo, gui or game:GetService("CoreGui"))

return CoCo