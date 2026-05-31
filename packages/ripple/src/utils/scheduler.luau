export type Scheduler<State> = {
	states: { State },
	update: (state: State, time: number) -> any,
	step: (deltaTime: number) -> (),
	add: (state: State) -> (),
	remove: (state: State) -> (),
	clear: () -> (),
}

local function scheduler<State>(
	label: string,
	updater: (state: State, time: number, remove: (State) -> ()) -> any
): Scheduler<State>
	local states: { State } = {}
	local count = 0

	local function remove(state: State)
		local index = table.find(states, state)

		if index then
			states[index] = states[count]
			states[count] = nil
			count -= 1
		end
	end

	local function step(deltaTime: number)
		for index = count, 1, -1 do
			updater(states[index], deltaTime, remove)
		end
	end

	local function update(state: State, time: number)
		return updater(state, time, remove)
	end

	local function add(state: State)
		if table.find(states, state) then
			return
		end

		table.insert(states, state)
		count += 1
	end

	local function clear()
		table.clear(states)
		count = 0
	end

	return {
		states = states,
		update = update,
		step = step,
		add = add,
		remove = remove,
		clear = clear,
	}
end

return scheduler
