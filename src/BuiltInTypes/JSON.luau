--!strict
local Services = require("../Shared/Services")
local HttpService = Services.HttpService

return function(coco)
	coco:registerType("json", {
		Validate = function(text)
			local success = pcall(HttpService.JSONDecode, HttpService, text)
			if not success then
				return false, "Invalid JSON"
			end
			return true
		end,

		Parse = function(text)
			return HttpService:JSONDecode(text)
		end
	})
end
