--!strict
local function Element(className, properties, children)
	local instance = Instance.new(className)

	for k, v in pairs(properties) do
		instance[k] = v
	end

	if children then
		for _, child in ipairs(children) do
			child.Parent = instance
		end
	end

	return instance
end

return Element
