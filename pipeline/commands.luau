--!strict
local fs = require("@lune/fs")

local COMMANDS_DIR = "src/BuiltInCommands"
local OUTPUT_FILE = "generated/commands.luau"

local function collectFiles(dir, results)
	for _, entry in ipairs(fs.readDir(dir)) do
		local fullPath = dir .. "/" .. entry
		if fs.isDir(fullPath) then
			collectFiles(fullPath, results)
		elseif fs.isFile(fullPath) then
			local moduleName = entry:match("^(.+)%.luau$") or entry:match("^(.+)%.lua$")
			if moduleName then
				local dirPart = dir .. "/"
				local modulePath = dirPart .. moduleName
				table.insert(results, (modulePath:gsub("\\", "/")))
			end
		end
	end
end

local files: { string } = {}
collectFiles(COMMANDS_DIR, files)
table.sort(files)

local lines: { string } = {}
table.insert(lines, "--!nocheck")
table.insert(lines, "return {")
for _, path in ipairs(files) do
	table.insert(lines, "\trequire(\"../" .. path .. "\"),")
end
table.insert(lines, "}")

fs.writeDir("generated")
fs.writeFile(OUTPUT_FILE, table.concat(lines, "\n"))
print(`Generated {OUTPUT_FILE} with {tostring(#files)} commands`)
