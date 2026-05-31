--!nocheck
--!native
--!nolint

-- MIT License


-- Copyright (c) 2024 Kalrnlo

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

-- cross
-- basic cross runtime utility, covering the bear nessisities

-- darklua doesnt like "task" and "warn"
local cross_task = require("./task")
local cross_warn = require("./warn")

type Runtime = "ROBLOX" | "LUNE" | "NONE"

local RUNTIME: Runtime = if game and game.ClassName == "DataModel" and game.GraphicsQualityChangeRequest then
		"ROBLOX"
	elseif string.find(_VERSION, "Lune") then
		"LUNE"
	else
		"NONE"

local WARN: typeof(cross_warn) = warn or cross_warn

local TASK: typeof(cross_task) = if task then 
		task 
	elseif RUNTIME == "LUNE" then 
		(require)("@lune/task") 
	else 
		cross_task

do

	local function SET_G(key: string, value: unknown)
		if not _G[key] then
			_G[key] = value
		end
	end

	if not _RUNTIME then
		SET_G("_RUNTIME", RUNTIME)
		_RUNTIME = RUNTIME
	end

	if not warn then
		SET_G("warn", WARN)
		warn = WARN
	end

	if not task then
		SET_G("task", TASK)
		task = TASK
	end

end

return table.freeze({
	cancel = TASK.cancel,
	spawn = TASK.spawn,
	defer = TASK.defer,
	delay = TASK.delay,
	wait = TASK.wait,
	warn = WARN,

	runtime = RUNTIME,
})