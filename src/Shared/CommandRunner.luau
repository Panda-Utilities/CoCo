--!strict
local String = require("./String")

local CommandRunner = {}

local function encodeCommandEscape(text)
	return (text:gsub("\\%$", "___!CMDR_DOLLAR!___"))
end

local function decodeCommandEscape(text)
	return (text:gsub("___!CMDR_DOLLAR!___", "$"))
end

function CommandRunner.runCommandString(dispatcher, commandString)
	commandString = String.parseEscapeSequences(commandString)
	commandString = String.encodeEscapedOperators(commandString)

	local commands = commandString:split("&&")

	local output = ""
	for i, command in ipairs(commands) do
		local outputEncoded = output:gsub("%$", "\\x24"):gsub("%%","%%%%")
		command = command:gsub("||", output:find("%s") and ("%q"):format(outputEncoded) or outputEncoded)

		output = tostring(
			dispatcher:evaluateAndRun(
				(
					CommandRunner.runEmbeddedCommands(dispatcher, command)
				)
			)
		)

		if i == #commands then
			return output
		end
	end
end

function CommandRunner.runEmbeddedCommands(dispatcher, str)
	str = encodeCommandEscape(str)

	local results = {}

	for text in str:gmatch("$(%b{})") do
		local doQuotes = true
		local commandString = text:sub(2, #text-1)

		if commandString:match("^{.+}$") then
			doQuotes = false
			commandString = commandString:sub(2, #commandString-1)
		end

		results[text] = CommandRunner.runCommandString(dispatcher, commandString)

		if doQuotes then
			if results[text]:find("%s") or results[text] == "" then
				results[text] = string.format("%q", results[text])
			end
		end
	end

	return decodeCommandEscape(str:gsub("$(%b{})", results))
end

function CommandRunner.substituteArgs(str, replace)
	str = encodeCommandEscape(str)
	if type(replace) == "table" then
		local copy = {}
		for i = 1, #replace do
			local v = replace[i]
			local k = tostring(i)
			copy[k] = v

			if v:find("%s") then
				copy[k] = string.format("%q", v)
			end
		end
		replace = copy
	end
	return decodeCommandEscape(str:gsub("($%d+)%b{}", "%1"):gsub("$(%w+)", replace))
end

function CommandRunner.makeAliasCommand(name, commandString)
	local commandName, commandDescription = unpack(name:split("|"))
	local args = {}

	commandString = String.encodeEscapedOperators(commandString)

	local seenArgs = {}

	for arg in commandString:gmatch("$(%d+)") do
		if seenArgs[arg] == nil then
			seenArgs[arg] = true
			local options = commandString:match(`${arg}(%b\{})`)

			local argOptional, argType, argName, argDescription
			if options then
				options = options:sub(2, #options - 1)
				argType, argName, argDescription = unpack(options:split("|"))
			end

			argOptional = argType and not not argType:match("%?$")
			argType = if argType then argType:match("^%w+") else "string"
			argName = argName or `Argument {arg}`
			argDescription = argDescription or ""

			table.insert(args, {
				Type = argType,
				Name = argName,
				Description = argDescription,
				Optional = argOptional,
			})
		end
	end

	return {
		Name = commandName,
		Aliases = {},
		Description = `<Alias> {commandDescription or commandString}`,
		Group = "UserAlias",
		Args = args,
		Run = function(context)
			return CommandRunner.runCommandString(context.Dispatcher, CommandRunner.substituteArgs(commandString, context.RawArguments))
		end,
	}
end

return CommandRunner
