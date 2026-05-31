local types = require("../types")

type Animatable = types.Animatable

local function interpolate<T>(from: any, to: any, alpha: number): any
	local kind = typeof(from)

	if kind == "number" or kind == "vector" then
		return from + (to - from) * alpha
	elseif kind == "table" then
		local result: { number | vector } = from

		for key, b in to do
			local a = from[key]

			if not a then
				continue
			end

			local value = a + (b - a) * alpha

			if result[key] ~= value then
				if result == from then
					result = table.clone(from)
				end
				result[key] = value
			end
		end

		return result
	else
		error(`Unsupported type for interpolation: {kind}`)
	end
end

return interpolate :: <T>(from: T, to: T, alpha: number) -> T
