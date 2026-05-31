--!strict
local Fuzzy = require("../Shared/Fuzzy")

return function(coco)
	coco:registerType("mathOperator", Fuzzy.makeEnumType("Math Operator", {
		{
			Name = "+",
			Perform = function(a, b)
				return a + b
			end
		},
		{
			Name = "-",
			Perform = function(a, b)
				return a - b
			end
		},
		{
			Name = "*",
			Perform = function(a, b)
				return a * b
			end
		},
		{
			Name = "/",
			Perform = function(a, b)
				return a / b
			end
		},
		{
			Name = "**",
			Perform = function(a, b)
				return a ^ b
			end
		},
		{
			Name = "%",
			Perform = function(a, b)
				return a % b
			end
		}
	}))
end
