--!strict
local CoCo do
	CoCo = setmetatable({}, {
		__index = function (self, k)
			local r = self.Registry[k]
			if r and type(r) == "function" then
				return function (_, ...)
					return r(self.Registry, ...)
				end
			end
		end
	})

	local Services = require("./Shared/Services")
	local Players = Services.Players

	CoCo.Registry = require("./Shared/Registry")(CoCo)
	CoCo.Dispatcher = require("./Shared/Dispatcher")(CoCo, Players.LocalPlayer)

	local _ = require("./Initialize")(CoCo)
end

return CoCo