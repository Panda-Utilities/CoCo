--!strict
local Config = require("../Config")

local ARGUMENT_SHORTHANDS = [[
Argument Shorthands
-------------------
.   Me/Self
*   All/Everyone
**  Others
?   Random
?N  List of N random values
]]

local TIPS = [[
Tips
----
• Utilize the Tab key to automatically complete commands
• Easily select and copy command output
]]

return {
	Name = "help",
	Description = "Displays a list of all commands, or inspects one command.",
	Group = "Help",
	Args = {
		{
			Type = "command",
			Name = "Command",
			Description = "The command to view information on",
			Optional = true,
		},
	},

	ClientRun = function (context, commandName)
		if commandName then
			local command = context.CoCo.Registry:getCommand(commandName)
			context:reply(`Command: {command.Name}`, Config.Colors.HelpOrange)
			if command.Aliases and #command.Aliases > 0 then
				context:reply(`Aliases: {table.concat(command.Aliases, ", ")}`, Config.Colors.HelpGray)
			end
			context:reply(command.Description, Config.Colors.HelpGray)
			for i, arg in ipairs(command.Args) do
				context:reply(
					`#{i} {arg.Name}{if arg.Optional == true then "?" else ""}: {arg.Type} - {arg.Description}`
				)
			end
		else
			context:reply(ARGUMENT_SHORTHANDS)
			context:reply(TIPS)

			local commands = context.CoCo.Registry:getCommands()
			table.sort(commands, function(a, b)
				return if a.Group and b.Group then a.Group < b.Group else a.Group
			end)
			local lastGroup
			for _, command in ipairs(commands) do
				command.Group = command.Group or "No Group"
				if lastGroup ~= command.Group then
					context:reply(`\n{command.Group}\n{string.rep("-", #command.Group)}`)
					lastGroup = command.Group
				end
				context:reply(if command.Description then `{command.Name} - {command.Description}` else command.Name)
			end
		end
		return ""
	end,
}
