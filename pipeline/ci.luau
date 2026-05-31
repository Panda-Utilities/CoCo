--!nocheck
--!nolint LocalUnused

local fs = require("@lune/fs")
local process = require("@lune/process")
local serde = require("@lune/serde")
local dateTime = require("@lune/datetime")

local configPath = process.args[1]
local config = serde.decode("json", fs.readFile(configPath))

local buildConfigs = config.buildConfigs
local buildConfig = buildConfigs[1]

local readme = fs.readFile("README.md")
local buildVers = readme:match("`(.-)`") or "ci"

local srcResult = process.exec("darklua", {
	"process",
	"-c",
	buildConfig.darkluaConfig,
	buildConfig.input,
	buildConfig.output,
})

if not srcResult.ok then
	error(srcResult.stderr)
end

local build = fs.readFile(buildConfig.output)
local frame = fs.readFile(buildConfig.frame)

local composerMarkers = {
	["__COMPOSER.Insert(__COMPOSER.build)"] = function()
		return build or ""
	end,
	["__COMPOSER.Insert(__COMPOSER.genDate)"] = function()
		return string.format("%q", dateTime.now():toIsoDate() or "")
	end,
	["__COMPOSER.Insert(__COMPOSER.cfg)"] = function()
		return string.format("%q", buildConfig.name)
	end,
	["__COMPOSER.Insert(__COMPOSER.vers)"] = function()
		return string.format("%q", buildVers)
	end,
}

for marker, replacement in pairs(composerMarkers) do
	frame = frame:gsub(marker:gsub("([%%%+%-%*%?%[%]%^%$%(%)%%])", "%%%1"), function()
		return replacement()
	end)
end

fs.writeFile(buildConfig.output, frame)
print("Build complete: " .. buildConfig.output)
