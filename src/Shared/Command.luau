--!strict
local Argument = require("./Argument")

local Command = {}
Command.__index = Command

function Command.new(options: {
	Dispatcher: any,
	Text: string,
	CommandObject: any,
	Alias: string,
	Executor: any?,
	Arguments: { string },
	Data: any?,
}): typeof(Command)
	local self = {
		Dispatcher = options.Dispatcher,
		CoCo = options.Dispatcher.CoCo,
		Name = options.CommandObject.Name,
		RawText = options.Text,
		Object = options.CommandObject,
		Group = options.CommandObject.Group,
		State = {},
		Aliases = options.CommandObject.Aliases,
		Alias = options.Alias,
		Description = options.CommandObject.Description,
		Executor = options.Executor,
		ArgumentDefinitions = options.CommandObject.Args,
		RawArguments = options.Arguments,
		Arguments = {},
		Data = options.Data,
		Response = nil,
	}

	setmetatable(self, Command)

	return self
end

function Command:parse(allowIncompleteArguments: boolean?): (boolean, string?)
	local hadOptional = false
	for i, definition in ipairs(self.ArgumentDefinitions) do
		if type(definition) == "function" then
			definition = definition(self)

			if definition == nil then
				break
			end
		end

		local required = (definition.Default == nil and definition.Optional ~= true)

		if required and hadOptional then
			error(`Command {self.Name:format("%q")}: Required arguments cannot occur after optional arguments.`)
		elseif not required then
			hadOptional = true
		end

		if self.RawArguments[i] == nil and required and allowIncompleteArguments ~= true then
			return false, `Required argument #{i} {definition.Name} is missing.`
		elseif self.RawArguments[i] or allowIncompleteArguments then
			self.Arguments[i] = Argument.new(self.Dispatcher.Registry, self, definition, self.RawArguments[i] or "")
		end
	end

	return true
end

function Command:validate(isFinal: boolean?): (boolean, string?)
	self._Validated = true
	local errorText = ""
	local success = true

	for i, arg in ipairs(self.Arguments) do
		local argSuccess, argErrorText = arg:Validate(isFinal)

		if not argSuccess then
			success = false
			errorText = `{errorText}; #{i} {arg.Name}: {argErrorText or "error"}`
		end
	end

	return success, errorText:sub(3)
end

function Command:getLastArgument()
	for i = #self.Arguments, 1, -1 do
		if self.Arguments[i].RawValue then
			return self.Arguments[i]
		end
	end
end

function Command:gatherArgumentValues(): ({ any }, number)
	local values = {}

	for i = 1, #self.ArgumentDefinitions do
		local arg = self.Arguments[i]
		if arg then
			values[i] = arg:GetValue()
		elseif type(self.ArgumentDefinitions[i]) == "table" then
			values[i] = self.ArgumentDefinitions[i].Default
		end
	end

	return values, #self.ArgumentDefinitions
end

function Command:run(): any?
	if self._Validated == nil then
		error("Must validate a command before running.")
	end

	local beforeRunHook = self.Dispatcher:runHooks("BeforeRun", self)
	if beforeRunHook then
		return beforeRunHook
	end

	if self.Object.Run then
		local values, length = self:gatherArgumentValues()
		self.Response = self.Object.Run(self, unpack(values, 1, length))
	elseif self.Object.ClientRun then
		local values, length = self:gatherArgumentValues()
		self.Response = self.Object.ClientRun(self, unpack(values, 1, length))
	else
		warn(self.Name, "command has no implementation!")
		self.Response = "No implementation."
	end

	local afterRunHook = self.Dispatcher:runHooks("AfterRun", self)
	if afterRunHook then
		return afterRunHook
	else
		return self.Response
	end
end

function Command:getArgument(index: number)
	return self.Arguments[index]
end

function Command:isInvertedCall(): boolean
	return self.Dispatcher.Registry:isInvertedCommand(self.Alias)
end

function Command:reply(text: string, color: Color3?)
	self.Dispatcher.CoCo.Events.AddLine:Fire(text, color)
end

function Command:getStore(...: string)
	return self.Dispatcher.CoCo.Registry:getStore(...)
end

return Command
