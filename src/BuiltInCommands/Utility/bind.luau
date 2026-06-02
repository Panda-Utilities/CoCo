--!strict
local CommandRunner = require("../../Shared/CommandRunner")
local Services = require("../../Shared/Services")
local UserInputService = Services.UserInputService

local function checkModifiers(specified)
	if not specified then specified = {} end

	local leftDown = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)
	local rightDown = UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
	local ctrlSpecified = specified[Enum.KeyCode.LeftControl] == true or specified[Enum.KeyCode.RightControl] == true
	if ctrlSpecified ~= (leftDown or rightDown) then return false end

	leftDown = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
	rightDown = UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
	local shiftSpecified = specified[Enum.KeyCode.LeftShift] == true or specified[Enum.KeyCode.RightShift] == true
	if shiftSpecified ~= (leftDown or rightDown) then return false end

	leftDown = UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt)
	rightDown = UserInputService:IsKeyDown(Enum.KeyCode.RightAlt)
	local altSpecified = specified[Enum.KeyCode.LeftAlt] == true or specified[Enum.KeyCode.RightAlt] == true
	if altSpecified ~= (leftDown or rightDown) then return false end

	return true
end

return {
	Name = "bind",
	Aliases = {},
	Description = "Binds a command to a key combination. Modes: toggle, hold. Use 'bind list' to see all binds.",
	Group = "DefaultUtil",
	Args = {
		{
			Type = "keycombo",
			Name = "Combo",
			Description = "Key combination (e.g. F2, Ctrl+F). Type 'list' to show all binds.",
		},
		{
			Type = "command",
			Name = "Command",
			Description = "The command to run",
			Optional = true,
		},
		{
			Type = "string",
			Name = "Arguments",
			Description = "Arguments for the command. Append ' hold' for hold-to-repeat mode.",
			Default = "",
		},
	},

	ClientRun = function(context, combo, command, arguments)
		local binds = context:getStore("COCO_Binds")

		local rawArgs = context.RawArguments
		if not rawArgs or #rawArgs == 0 then
			return [[Usage: bind <combo> <command> [args...]
  bind list           — show all binds
  bind F2 fly         — fire "fly" on F2
  bind Ctrl+Shift+F fly speed 100 hold  — hold mode]]
		end

		if rawArgs[1]:lower() == "list" then
			local count = 0
			for key, data in pairs(binds) do
				if type(data) == "table" and data.mode then
					count = count + 1
					context:reply(("%s  [%s]  %s %s"):format(
						key, data.mode or "toggle", data.command or "", data.args or ""
					))
				end
			end
			if count == 0 then
				return "No binds active."
			end
			return ("%d bind(s) active."):format(count)
		end

		if not combo then
			return "Invalid key combination."
		end

		if not command then
			return ("%s is not currently bound."):format(combo.text)
		end

		local args = arguments or ""
		local mode = "toggle"
		local lastWord = args:match("(%S+)$")
		if lastWord == "hold" then
			mode = lastWord
			args = #args > #lastWord and args:sub(1, #args - #lastWord - 1) or ""
		end

		local comboText = combo.text
		local fullCommand = command .. " " .. args

		local existing = binds[comboText]
		if existing and existing.connections then
			for _, conn in ipairs(existing.connections) do
				conn:Disconnect()
			end
		end

		local function runCmd()
			local result = context.Dispatcher:evaluateAndRun(
				CommandRunner.runEmbeddedCommands(context.Dispatcher, fullCommand)
			)
			if result then
				context:reply(tostring(result))
			end
		end

		local connections = {}

		if mode == "toggle" then
			local canFire = true
			connections[1] = UserInputService.InputBegan:Connect(function(input, gameProcessed)
				if gameProcessed then return end
				if input.KeyCode ~= combo.key then return end
				if not canFire then return end
				if not checkModifiers(combo.modifiers) then return end

				canFire = false
				runCmd()
			end)
			connections[#connections + 1] = UserInputService.InputEnded:Connect(function(input)
				if input.KeyCode == combo.key then
					canFire = true
				end
			end)
		elseif mode == "hold" then
			connections[1] = UserInputService.InputBegan:Connect(function(input, gameProcessed)
				if gameProcessed then return end
				if input.KeyCode ~= combo.key then return end
				if not checkModifiers(combo.modifiers) then return end

				runCmd()
			end)
			connections[#connections + 1] = UserInputService.InputEnded:Connect(function(input)
				if input.KeyCode == combo.key then
					runCmd()
				end
			end)
		end

		binds[comboText] = {
			mode = mode,
			key = combo.key,
			modifiers = combo.modifiers,
			command = command,
			args = args,
			connections = connections,
		}

		local serializableBinds = require("../../Shared/ConfigManager"):getBinds()
		serializableBinds[comboText] = {
			mode = mode,
			key = combo.key.Name,
			modifiers = {},
			command = command,
			args = args,
		}
		for modKey in pairs(combo.modifiers or {}) do
			table.insert(serializableBinds[comboText].modifiers, modKey.Name)
		end
		require("../../Shared/ConfigManager"):setBinds(serializableBinds)

		return ("Bound %q \u{2192} [%s] %s %s"):format(comboText, mode, command, args)
	end,
}
