--!strict
local TypeUtils = require("./TypeUtils")
local Sift = require("../../packages/sift")

export type TypeObject = {
	Name: string?,
	DisplayName: string?,
	Transform: ((string, Player?) -> any)?,
	Validate: ((any) -> (boolean, string?))?,
	ValidateOnce: ((any) -> (boolean, string?))?,
	Autocomplete: ((any, any) -> ({ string }, { IsPartial: boolean? }?))?,
	Parse: ((any) -> any)?,
	Default: ((Player) -> string)?,
	Listable: boolean?,
	Prefixes: string?,
	ArgumentOperatorAliases: { [string]: string }?,
	Selectors: { Keyword: { [string]: ((Player) -> { string }) | string }?, Pattern: { { Pattern: string, Resolve: ((Player, { string }) -> { string })?, Invert: ((Player, { string }) -> { string })? } }? }?,
}

export type ArgDef = {
	Name: string,
	Type: string | TypeObject,
	Description: string?,
	Optional: boolean?,
	Default: any?,
}

export type CommandObject = {
	Name: string,
	Aliases: { string }?,
	Description: string?,
	Group: string?,
	Args: { ArgDef | ((Command) -> ArgDef?) }?,
	Run: ((Command, ...any) -> any)?,
	ClientRun: ((Command, ...any) -> any)?,
	Data: any?,
	AutoExec: boolean?,
}

local Registry = {
	TypeMethods = TypeUtils.makeDictionary({ "Transform", "Validate", "Autocomplete", "Parse", "DisplayName", "Listable",
		"ValidateOnce", "Prefixes", "Default", "ArgumentOperatorAliases", "Selectors" }),
	CommandMethods = TypeUtils.makeDictionary({ "Name", "Aliases", "AutoExec", "Description", "Args", "Run", "ClientRun",
		"Data", "Group" }),
	CommandArgProps = TypeUtils.makeDictionary({ "Name", "Type", "Description", "Optional", "Default" }),
	Types = {},
	TypeAliases = {},
	Commands = {},
	CommandsArray = {},
	Hooks = {
		BeforeRun = {},
		AfterRun = {}
	},
	Stores = setmetatable({}, {
		__index = function(self: { [string]: { [any]: any } }, k: string)
			self[k] = {}
			return self[k]
		end
	}),
}

type Hook = { callback: (any) -> any?, priority: number }

function Registry:registerType(name: string, typeObject: TypeObject)
	if not name or typeof(name) ~= "string" then
		error("Invalid type name provided: nil")
	end

	if not name:find("^[%d%l]%w*$") then
		error(`Invalid type name provided: "{name}", type names must be alphanumeric and start with a lower-case letter or a digit.`)
	end

	for key in pairs(typeObject) do
		if self.TypeMethods[key] == nil then
			error(`Unknown key/method in type "{name}": {key}`)
		end
	end

	if self.Types[name] ~= nil then
		error(`Type "{name}" has already been registered.`)
	end

	typeObject.Name = name
	typeObject.DisplayName = typeObject.DisplayName or name

	self.Types[name] = typeObject

	if typeObject.Prefixes then
		self:registerTypePrefix(name, typeObject.Prefixes)
	end
end

function Registry:registerTypePrefix(name: string, union: string)
	if not self.TypeAliases[name] then
		self.TypeAliases[name] = name
	end

	self.TypeAliases[name] = `{self.TypeAliases[name]} {union}`
end

function Registry:registerTypeAlias(name: string, alias: string)
	if self.TypeAliases[name] ~= nil then
		error(`Type alias {alias} already exists!`)
	end
	self.TypeAliases[name] = alias
end

function Registry:registerCommandObject(commandObject: CommandObject)
	for key in pairs(commandObject) do
		if self.CommandMethods[key] == nil then
			error(`Unknown key/method in command {commandObject.Name or "unknown command"}: {key}`)
		end
	end

	if commandObject.Args then
		for i, arg in ipairs(commandObject.Args) do
			if type(arg) == "table" then
				for key in pairs(arg) do
					if self.CommandArgProps[key] == nil then
						error(`Unknown property in command "{commandObject.Name or "unknown"}" argument #{i}: {key}`)
					end
				end
			end
		end
	end

	local oldCommand = self.Commands[commandObject.Name:lower()]
	if oldCommand and oldCommand.Aliases then
		for _, alias in ipairs(oldCommand.Aliases) do
			self.Commands[alias:lower()] = nil
		end
	elseif not oldCommand then
		table.insert(self.CommandsArray, commandObject)
	end

	self.Commands[commandObject.Name:lower()] = commandObject

	if commandObject.Aliases then
		for _, alias in ipairs(commandObject.Aliases) do
			self.Commands[alias:lower()] = commandObject
		end
	end
end

function Registry:getCommand(name: string): CommandObject?
	name = name or ""
	return self.Commands[name:lower()]
end

function Registry:getCommands(): { CommandObject }
	return self.CommandsArray
end

function Registry:getCommandNames(): { string }
	return Sift.List.map(self.CommandsArray, function(command: CommandObject): string
		return command.Name
	end)
end

function Registry:getTypeNames(): { string }
	return Sift.Dictionary.keys(self.Types)
end

function Registry:getType(name: string): TypeObject?
	return self.Types[name]
end

function Registry:getTypeName(name: string): string
	return self.TypeAliases[name] or name
end

function Registry:registerHook(hookName: string, callback: (any) -> any?, priority: number?)
	if not self.Hooks[hookName] then
		error(`Invalid hook name: {hookName}`, 2)
	end

	table.insert(self.Hooks[hookName], { callback = callback, priority = priority or 0 })
	table.sort(self.Hooks[hookName], function(a: Hook, b: Hook): boolean
		return a.priority < b.priority
	end)
end


function Registry:getStore(name: string): { [any]: any }
	return self.Stores[name]
end

return function(_coco: any): typeof(Registry)
	return Registry
end
