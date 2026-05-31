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
	}

	for _, registerType in ipairs(types) do
		registerType(coco)
	end

	local commands = {
		require("./BuiltInCommands/help"),

		require("./BuiltInCommands/Utility/alias"),
		require("./BuiltInCommands/Utility/bind"),
		require("./BuiltInCommands/Utility/clear"),
		require("./BuiltInCommands/Utility/date"),
		require("./BuiltInCommands/Utility/echo"),
		require("./BuiltInCommands/Utility/edit"),
		require("./BuiltInCommands/Utility/history"),
		require("./BuiltInCommands/Utility/hover"),
		require("./BuiltInCommands/Utility/decode"),
		require("./BuiltInCommands/Utility/encode"),
		require("./BuiltInCommands/Utility/len"),
		require("./BuiltInCommands/Utility/keybind"),
		require("./BuiltInCommands/Utility/math"),
		require("./BuiltInCommands/Utility/pick"),
		require("./BuiltInCommands/Utility/rand"),
		require("./BuiltInCommands/Utility/replace"),
		require("./BuiltInCommands/Utility/resolve"),
		require("./BuiltInCommands/Utility/run"),
		require("./BuiltInCommands/Utility/runif"),
		require("./BuiltInCommands/Utility/runLines"),
		require("./BuiltInCommands/Utility/unbind"),
		require("./BuiltInCommands/Utility/var"),
		require("./BuiltInCommands/Utility/varSet"),

		require("./BuiltInCommands/Debug/blink"),
		require("./BuiltInCommands/Debug/fly"),
		require("./BuiltInCommands/Debug/position"),
		require("./BuiltInCommands/Debug/thru"),
		require("./BuiltInCommands/Debug/version"),
		require("./BuiltInCommands/Debug/rejoin"),
		require("./BuiltInCommands/Debug/serverhop"),
		require("./BuiltInCommands/Debug/noclip"),
		require("./BuiltInCommands/Debug/anchor"),
		require("./BuiltInCommands/Debug/fov"),
	}

	for _, commandDef in ipairs(commands) do
		coco.Registry:registerCommandObject(commandDef)
	end
end
