--!strict
return function(coco)
	coco.Registry:registerType("flymethod", {
		Transform = function(text) return text end,
		Validate = function(value) return value ~= nil end,
		Parse = function(value) return value end,
		Autocomplete = function(text)
			local all = {"velocity", "speed", "vehicle", "cframe"}
			if not text or #text == 0 then return all end
			local t = text:lower()
			local results = {}
			for _, v in ipairs(all) do
				if v:sub(1, #t) == t then
					table.insert(results, v)
				end
			end
			return results
		end,
	})

	coco.Registry:registerType("flykeybinds", {
		Transform = function(text) return text end,
		Validate = function(value) return value ~= nil end,
		Parse = function(value) return value end,
		Autocomplete = function(text)
			local all = {"default", "qe"}
			if not text or #text == 0 then return all end
			local t = text:lower()
			local results = {}
			for _, v in ipairs(all) do
				if v:sub(1, #t) == t then
					table.insert(results, v)
				end
			end
			return results
		end,
	})
end
