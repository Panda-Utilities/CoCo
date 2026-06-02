--!strict
local Services = require("./Services")
local HttpService = Services.HttpService
local UserInputService = Services.UserInputService
local CommandRunner = require("./CommandRunner")
local Config = require("../Config")

local CONFIG_FILE = Config.Gui.ConfigFile

local ConfigManager = {
	_data = nil,
}

function ConfigManager:ensureData()
	if not self._data then
		self:load()
	end
	return self._data
end

function ConfigManager:load()
	local success, data = pcall(readfile, CONFIG_FILE)
	if success and data and #data > 0 then
		local ok, decoded = pcall(HttpService.JSONDecode, HttpService, data)
		if ok and type(decoded) == "table" then
			self._data = decoded
			return self._data
		end
	end

	self._data = {
		activationKeys = {},
		binds = {},
		aliases = {},
	}
	return self._data
end

function ConfigManager:save()
	if not self._data then return end
	local success, encoded = pcall(HttpService.JSONEncode, HttpService, self._data)
	if not success then
		warn("CoCo: Failed to encode config.")
		return
	end
	local writeSuccess = pcall(writefile, CONFIG_FILE, encoded)
	if not writeSuccess then
		warn("CoCo: Failed to write config to " .. CONFIG_FILE)
	end
end

function ConfigManager:getActivationKeys(): { Enum.KeyCode }
	local data = self:ensureData()
	local keys = data.activationKeys
	if type(keys) ~= "table" then return {} end
	local result = {}
	for _, keyName in ipairs(keys) do
		local key = Enum.KeyCode[keyName]
		if key then
			table.insert(result, key)
		end
	end
	return result
end

function ConfigManager:setActivationKeys(keys: { Enum.KeyCode })
	local data = self:ensureData()
	local keyNames = {}
	for _, key in ipairs(keys) do
		table.insert(keyNames, key.Name)
	end
	data.activationKeys = keyNames
	self:save()
end

function ConfigManager:getBinds(): { [string]: { mode: string, key: string, modifiers: { string }, command: string, args: string } }
	local data = self:ensureData()
	return data.binds or {}
end

function ConfigManager:setBinds(binds: {})
	local data = self:ensureData()
	data.binds = binds
	self:save()
end

function ConfigManager:getAliases(): { [string]: string }
	local data = self:ensureData()
	return data.aliases or {}
end

function ConfigManager:setAliases(aliases: { [string]: string })
	local data = self:ensureData()
	data.aliases = aliases
	self:save()
end

function ConfigManager:apply(coco: any)
	self:ensureData()
	local data = self._data

	local keys = self:getActivationKeys()
	if #keys > 0 then
		coco:setActivationKeys(keys)
	end

	local aliases = self:getAliases()
	for name, commandString in pairs(aliases) do
		local ok = pcall(function()
			coco.Registry:registerCommandObject(
				CommandRunner.makeAliasCommand(name, commandString),
				true
			)
		end)
		if not ok then
			warn("CoCo: Failed to load alias: " .. tostring(name))
		end
	end

	local binds = self:getBinds()
	for comboText, bindData in pairs(binds) do
		local ok = pcall(function()
			self:_createBind(coco, comboText, bindData)
		end)
		if not ok then
			warn("CoCo: Failed to load bind: " .. tostring(comboText))
		end
	end
end

function ConfigManager:_createBind(coco: any, comboText: string, bindData: {})
	local Dispatcher = coco.Dispatcher
	local fullCommand = bindData.command .. " " .. (bindData.args or "")
	local mode = bindData.mode or "toggle"
	local key = Enum.KeyCode[bindData.key]
	if not key then return end

	local modifiers = {}
	for _, modName in ipairs(bindData.modifiers or {}) do
		local modKey = Enum.KeyCode[modName]
		if modKey then
			modifiers[modKey] = true
		end
	end

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

	local function runCmd()
		local result = Dispatcher:evaluateAndRun(
			CommandRunner.runEmbeddedCommands(Dispatcher, fullCommand)
		)
		if result then
			coco.Events.AddLine:Fire(tostring(result))
		end
	end

	local connections = {}
	local cocoBinds = coco.Registry:getStore("COCO_Binds")

	if mode == "toggle" then
		local canFire = true
		connections[1] = UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			if input.KeyCode ~= key then return end
			if not canFire then return end
			if not checkModifiers(modifiers) then return end

			canFire = false
			runCmd()
		end)
		connections[#connections + 1] = UserInputService.InputEnded:Connect(function(input)
			if input.KeyCode == key then
				canFire = true
			end
		end)
	elseif mode == "hold" then
		connections[1] = UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			if input.KeyCode ~= key then return end
			if not checkModifiers(modifiers) then return end

			runCmd()
		end)
		connections[#connections + 1] = UserInputService.InputEnded:Connect(function(input)
			if input.KeyCode == key then
				runCmd()
			end
		end)
	end

	cocoBinds[comboText] = {
		mode = mode,
		key = key,
		modifiers = modifiers,
		command = bindData.command,
		args = bindData.args or "",
		connections = connections,
	}
end

return ConfigManager
