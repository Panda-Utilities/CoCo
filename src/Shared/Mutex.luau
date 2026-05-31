--!strict
local Mutex = {}

function Mutex.new()
	local queue = {}
	local locked = false

	return function ()
		if locked then
			table.insert(queue, coroutine.running())
			coroutine.yield()
		else
			locked = true
		end

		return function()
			if #queue > 0 then
				coroutine.resume(table.remove(queue, 1))
			else
				locked = false
			end
		end
	end
end

return Mutex
