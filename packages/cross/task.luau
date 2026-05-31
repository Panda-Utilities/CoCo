--!native

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

-- task
-- a good enough pure luau version of roblox's task lib
-- that doesnt require wrapping ur whole script in a
-- task.spawn or anything

local function SPAWN<A..., R...>(
	thread_or_func: thread | (A...) -> R..., 
	...: A...
): thread
	if type(thread_or_func) == "thread" then
		coroutine.resume(thread_or_func, ...)
		return thread_or_func
	else
		local thread = coroutine.create(thread_or_func)
		coroutine.resume(thread, ...)
		return thread
	end
end

local function CANCEL(thread: thread)
	local success, result = coroutine.close(thread)

	if not success then
		error(`[TASK] could not cancel thread\n\terror: {result}`)
	end
end

local function WAIT(seconds: number?): number
	local start_time = os.clock()
	local end_time = start_time + (seconds or 1)
	local clock_time: number

	repeat
		clock_time = os.clock()
	until clock_time >= end_time
	return clock_time - start_time
end

local function DELAY<A..., R...>(
	seconds: number,
	thread_or_func: thread | (A...) -> R..., 
	...: A...
): thread
	local thread = SPAWN(function(
		seconds: number,
		thread_or_func: thread | (A...) -> R..., 
		...: A...
	)
		WAIT(seconds)

		if type(thread_or_func) == "thread" then
			coroutine.resume(thread_or_func, ...)
		else
			thread_or_func(...)
		end
	end, seconds, thread_or_func, ...)

	return thread
end

return table.freeze({
	cancel = CANCEL,
	spawn = SPAWN,
	defer = SPAWN,
	delay = DELAY,
	wait = WAIT,
})