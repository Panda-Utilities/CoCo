local Config = require("../../Config")

return {
	Name = "plugins",
	Description = "Lists all plugins (loaded and available).",
	Group = "Plugins",
	Args = {},

	ClientRun = function(context)
		local plugins = context.CoCo.PluginManager:list()

		if #plugins == 0 then
			context:reply("No plugins found.")
			return ""
		end

		context:reply("Plugins", Config.Colors.TextAccent)

		for _, p in ipairs(plugins) do
			local status = if p.Loaded then "[Loaded]" else "[---]"
			local desc = ""
			if p.Loaded and #p.Description > 0 then
				desc = ": " .. p.Description
			end
			local version = ""
			if p.Loaded and #p.Version > 0 then
				version = " (v" .. p.Version .. ")"
			end
			context:reply(string.format("  %s %s%s%s", status, p.Name, version, desc))
		end

		return ""
	end,
}
