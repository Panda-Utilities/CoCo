--!strict
local CreateGui = require("./CreateGui")

return function(coco)
	CreateGui()

	local types = {
		require("./BuiltInTypes/Primitives"),
		require("./BuiltInTypes/Player"),
		require("./BuiltInTypes/Team"),
		require("./BuiltInTypes/BrickColor"),
		require("./BuiltInTypes/Color3"),
		require("./BuiltInTypes/Vector"),
		require("./BuiltInTypes/Command"),
		require("./BuiltInTypes/Type"),
		require("./BuiltInTypes/BindableResource"),
		require("./BuiltInTypes/ConditionFunction"),
		require("./BuiltInTypes/Duration"),
		require("./BuiltInTypes/JSON"),
		require("./BuiltInTypes/MathOperator"),
		require("./BuiltInTypes/PlayerId"),
		require("./BuiltInTypes/StoredKey"),
		require("./BuiltInTypes/URL"),
		require("./BuiltInTypes/UserInput"),
		require("./BuiltInTypes/KeyCombo"),
		require("./BuiltInTypes/Fly"),
		require("./BuiltInTypes/ScriptBlox"),
	}

	for _, registerType in ipairs(types) do
		registerType(coco)
	end

	local commands = require("./../generated/commands")

	for _, commandDef in ipairs(commands) do
		coco.Registry:registerCommandObject(commandDef)
	end
end
