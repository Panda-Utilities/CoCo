--!strict
local Fuzzy = require("../Shared/Fuzzy")

return function (coco)
	coco:registerType("bindableResource", Fuzzy.makeEnumType("BindableResource", {"Chat"}))
end
