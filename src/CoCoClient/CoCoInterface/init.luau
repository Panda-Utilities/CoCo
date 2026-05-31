--!strict
local String = require("../../Shared/String")

return function (CoCo, gui)
	local Window = require("./Window")
	Window.CoCo = CoCo
	Window.GuiRoot = gui

	local cocoGui = gui:FindFirstChild("CoCo")
	local AutoComplete = require("./AutoComplete")(CoCo, cocoGui or gui)
	Window.AutoComplete = AutoComplete

	function Window.ProcessEntry(text)
		text = String.trimString(text)
		if #text == 0 then return end

		Window:addLine(Window:getLabel() .. " " .. text, Color3.fromRGB(255, 223, 93))
		Window:addLine(CoCo.Dispatcher:evaluateAndRun(text))
	end

	function Window.OnTextChanged(text)
		local command = CoCo.Dispatcher:evaluate(text, CoCo.Dispatcher._defaultExecutor, true)
		local arguments = String.splitString(text)
		local commandText = table.remove(arguments, 1)
		local atEnd = false
		if command then
			arguments = String.mashExcessArguments(arguments, #command.Object.Args)
			atEnd = #arguments == #command.Object.Args
		end

		local entryComplete = commandText and #arguments > 0

		if text:sub(#text, #text):match("%s") and not atEnd then
			entryComplete = true
			arguments[#arguments + 1] = ""
		end

		if command and entryComplete then
			local commandValid, errorText = command:validate()

			Window:setIsValidInput(commandValid, ("Validation errors: %s"):format(errorText or ""))

			local acItems = {}

			local lastArgument = command:getArgument(#arguments)
			if lastArgument then
				local typedText = lastArgument.TextSegmentInProgress

				local isPartial = false
				if lastArgument.RawSegmentsAreAutocomplete then
					for i, segment in ipairs(lastArgument.RawSegments) do
						acItems[i] = {segment, segment}
					end
				else
					local items, options = lastArgument:GetAutocomplete()
					options = options or {}
					isPartial = options.IsPartial or false

					for i, item in ipairs(items) do
						acItems[i] = {typedText, item}
					end
				end

				local valid = true

				if #typedText > 0 then
					valid, errorText = lastArgument:Validate()
				end

				if not atEnd and valid then
					Window:hideInvalidState()
				end

				return AutoComplete:show(acItems, {
					at = atEnd and #text - #typedText + (text:sub(#text, #text):match("%s") and -1 or 0);
					prefix = #lastArgument.RawSegments == 1 and lastArgument.Prefix or "";
					isLast = #command.Arguments == #command.ArgumentDefinitions and #typedText > 0;
					numArgs = #arguments;
					command = command;
					arg = lastArgument;
					name = lastArgument.Name .. (lastArgument.Required and "" or "?");
					type = lastArgument.Type.DisplayName;
					description = (valid == false and errorText) or lastArgument.Object.Description;
					invalid = not valid;
					isPartial = isPartial;
				})
			end
		elseif commandText and #arguments == 0 then
			Window:setIsValidInput(true)
			local exactCommand = CoCo.Registry:getCommand(commandText)
			local exactMatch
			if exactCommand then
				exactMatch = {exactCommand.Name, exactCommand.Name, options = {
					name = exactCommand.Name;
					description = exactCommand.Description;
				}}

				local arg = exactCommand.Args and exactCommand.Args[1]
				if type(arg) == "function" then
					arg = arg(command)
				end

				if arg and (not arg.Optional and arg.Default == nil) then
					Window:setIsValidInput(false, "This command has required arguments.")
					Window:hideInvalidState()
				end
			end

			local acItems = exactMatch and {exactMatch} or {}
			for _, cmd in ipairs(CoCo.Registry:getCommandNames()) do
				if commandText:lower() == cmd:lower():sub(1, #commandText) and (exactMatch == nil or exactMatch[1] ~= cmd) then
					local commandObject = CoCo.Registry:getCommand(cmd)
					acItems[#acItems + 1] = {commandText, cmd, options = {
						name = commandObject.Name;
						description = commandObject.Description;
					}}
				end
			end

			if #acItems > 0 then
				return AutoComplete:show(acItems)
			end

			Window:setIsValidInput(false, ("%q is not a valid command name. Use the help command to see all available commands."):format(commandText))
			AutoComplete:hide()
		end

		Window:setIsValidInput(false, "Use the help command to see all available commands.")
		AutoComplete:hide()
	end

	Window:updateLabel()
	Window:updateWindowHeight()

	return {
		Window = Window;
		AutoComplete = AutoComplete;
	}
end