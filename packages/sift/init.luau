local function map<T, U>(array: { T }, mapper: (value: T, index: number, array: { T }) -> U?): { U }
	local mapped = {}
	for index, value in ipairs(array) do
		local mappedValue = mapper(value, index, array)
		if mappedValue ~= nil then
			table.insert(mapped, mappedValue)
		end
	end
	return mapped
end

local function filter<T>(array: { T }, predicate: ((value: T, index: number, array: { T }) -> boolean?)?): { T }
	local result = {}
	predicate = if type(predicate) == "function" then predicate else function(v) return v end
	for index, value in ipairs(array) do
		if predicate(value, index, array) then
			table.insert(result, value)
		end
	end
	return result
end

local function reduce<T, U>(array: { T }, reducer: (accumulator: U, value: T, index: number) -> U, initial: U): U
	local acc = initial
	for index, value in ipairs(array) do
		acc = reducer(acc, value, index)
	end
	return acc
end

local function find<T>(array: { T }, predicate: (value: T, index: number) -> boolean): T?
	for index, value in ipairs(array) do
		if predicate(value, index) then
			return value
		end
	end
	return nil
end

local function some<T>(array: { T }, predicate: (value: T, index: number) -> boolean): boolean
	for index, value in ipairs(array) do
		if predicate(value, index) then
			return true
		end
	end
	return false
end

local function merge<K, V>(...: { [K]: V }): { [K]: V }
	local result = {}
	for i = 1, select("#", ...) do
		local dict = select(i, ...)
		for k, v in dict do
			result[k] = v
		end
	end
	return result
end

local function keys(dict: { [any]: any }): { any }
	local result = {}
	for k in dict do
		table.insert(result, k)
	end
	return result
end

local Sift = {
	Array = {
		map = map,
		filter = filter,
		reduce = reduce,
		find = find,
		some = some,
	},
	Dictionary = {
		merge = merge,
		keys = keys,
	},
}

Sift.List = Sift.Array

return Sift
