--!strict
local String = require("./String")
local Command = require("./Command")
local Config = require("../Config")

local HISTORY_FILE = Config.Gui.HistoryFile

local Dispatcher = {
	CoCo = nil,
	Registry = nil,
}

function Dispatcher:evaluate(text: string, executor: any?, allowIncompleteArguments: boolean?, data: any?)
	local arguments = String.splitString(text)
	local commandName = table.remove(arguments, 1)
	local commandObject = self.Registry:getCommand(commandName)

	if commandObject then
		arguments = String.mashExcessArguments(arguments, #commandObject.Args)

		local command = Command.new({
			Dispatcher = self,
			Text = text,
			CommandObject = commandObject,
			Alias = commandName,
			Executor = executor,
			Arguments = arguments,
			Data = data
		})
		local success, errorText = command:parse(allowIncompleteArguments)

		if success then
			return command
		else
			return false, errorText
		end
	else
		return false,
			(`%q is not a valid command name. Use the help command to see all available commands.`):format(tostring(commandName))
	end
end

function Dispatcher:evaluateAndRun(text: string, executor: any?): string
	executor = executor or self._defaultExecutor

	if executor then
		self:pushHistory(text)
	end

	local command, errorText = self:evaluate(text, executor)

	if not command then
		return errorText
	end

	local ok, out = xpcall(function()
		local valid, errorText = command:validate(true)

		if not valid then
			return errorText
		end

		return command:run() or "Command executed."
	end, function(value: any): string
		return debug.traceback(tostring(value))
	end)

	if not ok then
		warn(`Error occurred while evaluating command string {text:format("%q")}\n{tostring(out)}`)
	end

	return ok and out or "An error occurred while running this command."
end

function Dispatcher:run(...: any): any
	local args = { ... }
	local text = args[1]
	local parts = {}

	for i = 2, #args do
		parts[#parts + 1] = tostring(args[i])
	end

	if #parts > 0 then
		text = text .. " " .. table.concat(parts, " ")
	end

	local command, errorText = self:evaluate(text, self._defaultExecutor)

	if not command then
		error(errorText)
	end

	local success, errorText = command:validate(true)

	if not success then
		error(errorText)
	end

	return command:run()
end

function Dispatcher:runHooks(hookName: string, commandContext: any, ...: any): string?
	if not self.Registry.Hooks[hookName] then
		error(`Invalid hook name: {hookName:format("%q")}`, 2)
	end

	for _, hook in ipairs(self.Registry.Hooks[hookName]) do
		local value = hook.callback(commandContext, ...)

		if value ~= nil then
			return tostring(value)
		end
	end
end

function Dispatcher:pushHistory(text: string)
	if String.trimString(text) == "" then
		return
	end

	local history = self:getHistory()
	if text == history[#history] then
		return
	end

	history[#history + 1] = text

	local writeSuccess = pcall(writefile, HISTORY_FILE, table.concat(history, "\n"))
	if not writeSuccess then
		warn("CoCo: Failed to write command history to " .. HISTORY_FILE)
	end
end

function Dispatcher:getHistory(): { string }
	local success, data = pcall(readfile, HISTORY_FILE)
	if success and data then
		local lines: { string } = {}
		for line in data:gmatch("[^\r\n]+") do
			table.insert(lines, line)
		end
		return lines
	end

	return {}
end

return function(coco: any, defaultExecutor: any): typeof(Dispatcher)
	Dispatcher.CoCo = coco
	Dispatcher.Registry = coco.Registry
	Dispatcher._defaultExecutor = defaultExecutor

	return Dispatcher
end
