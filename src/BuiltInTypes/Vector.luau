--!strict
local TypeUtils = require("../Shared/TypeUtils")

local function validateVector(value, i)
	if value == nil then
		return false, ("Invalid or missing number at position %d in Vector type."):format(i)
	end

	return true
end

local vector3Type = TypeUtils.makeSequenceType({
	ValidateEach = validateVector,
	TransformEach = tonumber,
	Constructor = Vector3.new,
	Length = 3,
})

local vector2Type = TypeUtils.makeSequenceType({
	ValidateEach = validateVector,
	TransformEach = tonumber,
	Constructor = Vector2.new,
	Length = 2,
})

return function (coco)
	coco:registerType("vector3", vector3Type)
	coco:registerType("vector3s", TypeUtils.makeListableType(vector3Type))

	coco:registerType("vector2", vector2Type)
	coco:registerType("vector2s", TypeUtils.makeListableType(vector2Type))
end
