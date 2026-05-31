--!strict
local Fuzzy = require("../Shared/Fuzzy")

return function (coco)
	coco:registerType("conditionFunction", Fuzzy.makeEnumType("ConditionFunction", {"startsWith"}))
end
