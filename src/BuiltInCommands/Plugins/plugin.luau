local PLUGIN_ACTIONS = { load = true, unload = true, reload = true, loadall = true }

return {
	Name = "plugin",
	Description = "Manages plugins: load/unload/reload/loadall.",
	Group = "Plugins",
	Args = {
		{
			Type = "string",
			Name = "Action",
			Description = "load, unload, reload, or loadall",
		},
		{
			Type = "string",
			Name = "Plugin name",
			Description = "The plugin to manage",
			Optional = true,
		},
	},

	ClientRun = function(context, action, pluginName)
		action = action:lower()

		if not PLUGIN_ACTIONS[action] then
			return "Invalid action. Use: load, unload, reload, or loadall."
		end

		local pm = context.CoCo.PluginManager

		if action == "loadall" then
			pm:loadAll()
			return "Loaded all plugins from disk."
		end

		if not pluginName or #pluginName == 0 then
			return "Please specify a plugin name."
		end

		if action == "load" then
			local ok, err = pm:load(pluginName)
			if ok then
				return "Loaded plugin \"" .. pluginName .. "\"."
			else
				return "Failed to load \"" .. pluginName .. "\": " .. tostring(err)
			end
		elseif action == "unload" then
			local ok, err = pm:unload(pluginName)
			if ok then
				return "Unloaded plugin \"" .. pluginName .. "\"."
			else
				return "Failed to unload \"" .. pluginName .. "\": " .. tostring(err)
			end
		elseif action == "reload" then
			local ok, err = pm:reload(pluginName)
			if ok then
				return "Reloaded plugin \"" .. pluginName .. "\"."
			else
				return "Failed to reload \"" .. pluginName .. "\": " .. tostring(err)
			end
		end

		return ""
	end,
}
