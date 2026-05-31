local cross = require("../../../cross")

local freeThread: thread?

local function run<T...>(thread: thread, fn: (T...) -> (), ...: T...)
	freeThread = nil
	fn(...)
	freeThread = thread
end

local function runner()
	while true do
		run(coroutine.yield())
	end
end

local function spawnImpl<T...>(callback: (T...) -> (), ...: T...)
	local thread = freeThread or coroutine.create(runner)
	freeThread = nil
	coroutine.resume(thread, thread, callback, ...)
end

return spawnImpl :: typeof(spawnImpl)
