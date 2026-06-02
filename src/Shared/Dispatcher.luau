--!strict
local String = require("./String")
local Command = require("./Command")
local Config = require("../Config")

local HISTORY_FILE = Config.Gui.HistoryFile
local HISTORY_MAX = 1000
local ActiveLoops: { [number]: { Active: boolean } } = {}
local loopCounter = 0

local function splitByAndRespectingQuotes(text: string): { string }
	local parts: { string } = {}
	local buf: { string } = {}
	local inQuotes = false
	local quoteChar: string? = nil
	local i = 1
	while i <= #text do
		local char = text:sub(i, i)
		if char == '"' or char == "'" then
			if not inQuotes then
				inQuotes = true
				quoteChar = char
			elseif char == quoteChar then
				inQuotes = false
			end
			table.insert(buf, char)
			i += 1
		elseif char == "&" and not inQuotes and text:sub(i, i + 1) == "&&" then
			parts[#parts + 1] = table.concat(buf)
			buf = {}
			i += 2
		else
			table.insert(buf, char)
			i += 1
		end
	end
	parts[#parts + 1] = table.concat(buf)
	return parts
end

local function parseLoopSyntax(text: string): (string?, string?, string?)
	local countStr, delayStr, cmdText = text:match("^(inf)%^([%d%.]+)%^(.+)$")
	if countStr then
		return countStr, delayStr, cmdText
	end
	countStr, delayStr, cmdText = text:match("^(%d+)%^([%d%.]+)%^(.+)$")
	if countStr then
		return countStr, delayStr, cmdText
	end
	countStr, cmdText = text:match("^(inf)%^(.+)$")
	if countStr then
		return countStr, nil, cmdText
	end
	countStr, cmdText = text:match("^(%d+)%^(.+)$")
	if countStr then
		return countStr, nil, cmdText
	end
	return nil, nil, nil
end

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

function Dispatcher:evaluateAndRun(text: string, executor: any?, skipHistory: boolean?): string
	text = String.trimString(text)
	if #text == 0 then
		return ""
	end

	local chainParts = splitByAndRespectingQuotes(text)
	if #chainParts > 1 then
		local lastOutput = ""
		for _, part in ipairs(chainParts) do
			local trimmed = String.trimString(part)
			if #trimmed > 0 then
				lastOutput = self:evaluateAndRun(trimmed, executor, skipHistory)
			end
		end
		return lastOutput
	end

	local countStr, delayStr, cmdText = parseLoopSyntax(text)
	if countStr then
		return self:runLoop(countStr, delayStr, cmdText, executor)
	end

	executor = executor or self._defaultExecutor

	if executor and not skipHistory then
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

function Dispatcher:runLoop(countStr: string, delayStr: string?, cmdText: string, executor: any?): string
	loopCounter += 1
	local loopId = loopCounter
	local loopInfo = { Active = true }
	ActiveLoops[loopId] = loopInfo

	local count = if countStr == "inf" then math.huge else assert(tonumber(countStr))
	local delay = if delayStr then tonumber(delayStr) or 0.0 else 0.0

	task.spawn(function()
		local i = 0
		while i < count do
			i += 1
			local info = ActiveLoops[loopId]
			if not info or not info.Active then
				break
			end
			local output = self:evaluateAndRun(cmdText, executor, true)
			if output and #output > 0 then
				pcall(function()
					self.CoCo.Events.AddLine:Fire(output)
				end)
			end
			if i < count then
				task.wait(if delay > 0 then delay else nil)
			end
		end
		ActiveLoops[loopId] = nil
	end)

	local countLabel = if countStr == "inf" then "infinite" else countStr
	local delayLabel = if delay > 0 then `, {delay}s delay` else ""
	return `Started loop #{loopId} ({countLabel} iterations{delayLabel}).`
end

function Dispatcher:breakLoops(): number
	local count = 0
	for id, info in pairs(ActiveLoops) do
		if info then
			info.Active = false
			count += 1
		end
	end
	for id in pairs(ActiveLoops) do
		ActiveLoops[id] = nil
	end
	return count
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

	if #history > HISTORY_MAX then
		for i = 1, #history - HISTORY_MAX do
			table.remove(history, 1)
		end
	end

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
	Dispatcher.splitByAndRespectingQuotes = splitByAndRespectingQuotes
	Dispatcher.parseLoopSyntax = parseLoopSyntax

	return Dispatcher
end
