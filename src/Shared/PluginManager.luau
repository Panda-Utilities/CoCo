local Config = require("../Config")
local Sift = require("../../packages/sift")

local PLUGIN_DIR = Config.Gui.PluginDir
local EXTENSION = ".coco"

local PluginManager = {
	CoCo = nil,
	Plugins = {},
}

function PluginManager:init(coco)
	self.CoCo = coco
	return self
end

function PluginManager:_getPluginPath(name)
	return PLUGIN_DIR .. "/" .. name .. EXTENSION
end

function PluginManager:_isPluginFile(name)
	return name:sub(-#EXTENSION) == EXTENSION
end

function PluginManager:_snapshotKeys()
	return {
		commands = Sift.Dictionary.keys(self.CoCo.Registry.Commands),
		types = Sift.Dictionary.keys(self.CoCo.Registry.Types),
	}
end

function PluginManager:_diffKeys(before, after)
	local added = {}
	for _, key in ipairs(after) do
		local found = false
		for _, old in ipairs(before) do
			if key == old then
				found = true
				break
			end
		end
		if not found then
			table.insert(added, key)
		end
	end
	return added
end

function PluginManager:load(name)
	if self.Plugins[name] then
		return nil, "Plugin \"" .. name .. "\" is already loaded."
	end

	local path = self:_getPluginPath(name)
	local success, data = pcall(readfile, path)
	if not success or not data or #data == 0 then
		return nil, "Could not read plugin file: " .. path
	end

	local ok, chunk = pcall(loadstring, data, "=" .. path)
	if not ok then
		return nil, "Failed to compile plugin \"" .. name .. "\": " .. tostring(chunk)
	end

	local ok2, pluginDef = pcall(chunk)
	if not ok2 or type(pluginDef) ~= "table" then
		return nil, "Plugin \"" .. name .. "\" did not return a valid table."
	end

	if type(pluginDef.Name) ~= "string" or #pluginDef.Name == 0 then
		return nil, "Plugin \"" .. name .. "\" is missing a valid Name field."
	end

	local pluginName = pluginDef.Name

	if self.Plugins[pluginName] then
		return nil, "Plugin \"" .. pluginName .. "\" is already loaded (duplicate name)."
	end

	if type(pluginDef.Init) ~= "function" then
		return nil, "Plugin \"" .. pluginName .. "\" is missing required Init function."
	end

	local snapshotBefore = self:_snapshotKeys()

	local ok3, initErr = pcall(pluginDef.Init, self.CoCo)
	if not ok3 then
		return nil, "Plugin \"" .. pluginName .. "\" Init failed: " .. tostring(initErr)
	end

	local snapshotAfter = self:_snapshotKeys()

	local entry = {
		Def = pluginDef,
		Name = pluginName,
		Description = pluginDef.Description or "",
		Version = pluginDef.Version or "",
		Author = pluginDef.Author or "",
		Commands = self:_diffKeys(snapshotBefore.commands, snapshotAfter.commands),
		Types = self:_diffKeys(snapshotBefore.types, snapshotAfter.types),
	}

	self.Plugins[pluginName] = entry
	return true, nil
end

function PluginManager:unload(name)
	local entry = self.Plugins[name]
	if not entry then
		return nil, "Plugin \"" .. name .. "\" is not loaded."
	end

	if entry.Def.Deinit then
		local ok, err = pcall(entry.Def.Deinit, self.CoCo)
		if not ok then
			warn("CoCo Plugin: Deinit failed for \"" .. name .. "\": " .. tostring(err))
		end
	end

	for _, cmdName in ipairs(entry.Commands) do
		self.CoCo.Registry:removeCommand(cmdName)
	end

	for _, typeName in ipairs(entry.Types) do
		self.CoCo.Registry:removeType(typeName)
	end

	self.Plugins[name] = nil
	return true, nil
end

function PluginManager:reload(name)
	local entry = self.Plugins[name]
	if not entry then
		return nil, "Plugin \"" .. name .. "\" is not loaded."
	end

	local prevDescription = entry.Description
	local prevVersion = entry.Version
	local prevAuthor = entry.Author

	local ok, err = self:unload(name)
	if not ok then
		return nil, "Failed to unload plugin \"" .. name .. "\": " .. tostring(err)
	end

	local ok2, err2 = self:load(name)
	if not ok2 then
		return nil, "Failed to reload plugin \"" .. name .. "\": " .. tostring(err2)
	end

	return true, nil
end

function PluginManager:_scanPluginDir()
	local success, paths = pcall(listfiles, PLUGIN_DIR)
	if not success or type(paths) ~= "table" then
		return {}
	end

	local names = {}
	for _, fullPath in ipairs(paths) do
		if isfile(fullPath) then
			local filename = fullPath:match("([^/\\]+)$")
			if filename and self:_isPluginFile(filename) then
				local name = filename:sub(1, -#EXTENSION - 1)
				if #name > 0 then
					table.insert(names, name)
				end
			end
		end
	end
	return names
end

function PluginManager:loadAll()
	local ok = pcall(isfolder, PLUGIN_DIR)
	if not ok then
		pcall(makefolder, PLUGIN_DIR)
		return
	end

	if not isfolder(PLUGIN_DIR) then
		pcall(makefolder, PLUGIN_DIR)
		return
	end

	local pluginNames = self:_scanPluginDir()
	table.sort(pluginNames)

	for _, name in ipairs(pluginNames) do
		local ok, err = self:load(name)
		if not ok then
			warn("CoCo Plugin: Failed to load \"" .. name .. "\": " .. tostring(err))
		end
	end
end

function PluginManager:list()
	local results = {}
	local onDisk = {}

	for _, name in ipairs(self:_scanPluginDir()) do
		onDisk[name] = true
	end

	for name, plugin in self.Plugins do
		table.insert(results, {
			Name = plugin.Name,
			Description = plugin.Description,
			Version = plugin.Version,
			Author = plugin.Author,
			Loaded = true,
		})
		onDisk[name] = nil
	end

	for name in pairs(onDisk) do
		table.insert(results, {
			Name = name,
			Description = "",
			Version = "",
			Author = "",
			Loaded = false,
		})
	end

	table.sort(results, function(a, b)
		return a.Name:lower() < b.Name:lower()
	end)

	return results
end

return function(coco)
	return PluginManager:init(coco)
end
