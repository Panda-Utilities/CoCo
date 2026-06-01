--!strict
local String = require("./String")
local TypeUtils = require("./TypeUtils")
local Set = require("./Set")
local Config = require("../Config")

local function unescapeOperators(text: string): string
	for _, operator in ipairs({ "%.", "%?", "%*", "%*%*" }) do
		text = text:gsub("\\" .. operator, operator:gsub("%%", ""))
	end

	return text
end

local Argument: { __index: typeof(Argument), new: (any, any, any, string) -> any } = {}
Argument.__index = Argument

function Argument.new(registry: any, command: any, argumentObject: any, value: string): typeof(Argument)
	local self = {
		Registry = registry,
		Command = command,
		Type = nil,
		Name = argumentObject.Name,
		Object = argumentObject,
		Required = argumentObject.Default == nil and argumentObject.Optional ~= true,
		Executor = command.Executor,
		RawValue = value,
		RawSegments = {},
		TransformedValues = {},
		Prefix = "",
		TextSegmentInProgress = "",
		RawSegmentsAreAutocomplete = false,
	}

	if type(argumentObject.Type) == "table" then
		self.Type = argumentObject.Type
	else
		local parsedType, parsedRawValue, prefix = TypeUtils.parsePrefixedUnionType(
			registry:getTypeName(argumentObject.Type),
			value
		)

		self.Type = registry:getType(parsedType)
		self.RawValue = parsedRawValue
		self.Prefix = prefix

		if self.Type == nil then
			error(string.format("%s has an unregistered type %q", self.Name or "<none>", parsedType or "<none>"))
		end
	end

	setmetatable(self, Argument)

	self:Transform()

	return self
end

function Argument:GetDefaultAutocomplete(): ({ string }, { IsPartial: boolean? }?)
	if self.Type.Autocomplete then
		local strings, options = self.Type.Autocomplete(self:TransformSegment(""), self)
		return strings, options or {}
	end

	return {}
end

function Argument:Transform()
	if #self.TransformedValues ~= 0 then
		return
	end

	local rawValue = self.RawValue
	if self.Type.ArgumentOperatorAliases then
		rawValue = self.Type.ArgumentOperatorAliases[rawValue] or rawValue
	end

	if rawValue == "." and self.Type.Default then
		rawValue = self.Type.Default(self.Executor) or ""
		self.RawSegmentsAreAutocomplete = true
	end

	if rawValue == "?" and self.Type.Autocomplete then
		local strings, options = self:GetDefaultAutocomplete()

		if not options.IsPartial and #strings > 0 then
			rawValue = strings[math.random(1, #strings)]
			self.RawSegmentsAreAutocomplete = true
		end
	end

	if self.Type.Selectors and not self.RawSegmentsAreAutocomplete and self.Executor then
		local resolved = self:resolveSelectorValue(rawValue)
		if resolved then
			if self.Type.Listable then
				rawValue = resolved
				self.RawSegmentsAreAutocomplete = true
			else
				local names = String.splitStringSimple(resolved, ",")
				if #names > 0 then
					rawValue = names[1]
				end
			end
		end
	end

	if not self.RawSegmentsAreAutocomplete and #self.RawValue > 0 then
		if rawValue == "*" or rawValue == "**" then
			local strings, options = self:GetDefaultAutocomplete()

			if not options.IsPartial and #strings > 0 then
				if rawValue == "**" and self.Type.Default then
					local defaultString = self.Type.Default(self.Executor) or ""
					local filtered = {}
					for _, name in ipairs(strings) do
						if name ~= defaultString then
							table.insert(filtered, name)
						end
					end
					strings = filtered
				end

				if self.Type.Listable then
					rawValue = table.concat(strings, ",")
					self.RawSegmentsAreAutocomplete = true
				elseif #strings > 0 then
					rawValue = strings[1]
				end
			end
		end
	end

	if self.Type.Listable and #self.RawValue > 0 then
		local randomMatch = rawValue:match("^%?(%d+)$")
		if randomMatch then
			local maxSize = tonumber(randomMatch)

			if maxSize and maxSize > 0 then
				local items = {}
				local remainingItems, options = self:GetDefaultAutocomplete()

				if not options.IsPartial and #remainingItems > 0 then
					local indices = {}
					for j = 1, #remainingItems do
						indices[j] = j
					end
					for _ = 1, math.min(maxSize, #remainingItems) do
						local chosen = math.random(1, #indices)
						table.insert(items, remainingItems[table.remove(indices, chosen)])
					end

					rawValue = table.concat(items, ",")
					self.RawSegmentsAreAutocomplete = true
				end
			end
		end

		rawValue = unescapeOperators(rawValue)

		local rawSegments = String.splitStringSimple(rawValue, ",")

		if #rawSegments == 0 then
			rawSegments = { "" }
		end

		if rawValue:sub(#rawValue, #rawValue) == "," then
			rawSegments[#rawSegments + 1] = ""
		end

		for i, rawSegment in ipairs(rawSegments) do
			self.RawSegments[i] = rawSegment
			self.TransformedValues[i] = { self:TransformSegment(rawSegment) }
		end

		self.TextSegmentInProgress = rawSegments[#rawSegments]
	else
		rawValue = unescapeOperators(rawValue)

		self.RawSegments[1] = unescapeOperators(rawValue)
		self.TransformedValues[1] = { self:TransformSegment(rawValue) }
		self.TextSegmentInProgress = self.RawValue
	end
end

function Argument:TransformSegment(rawSegment: string): any
	if self.Type.Transform then
		return self.Type.Transform(rawSegment, self.Executor)
	else
		return rawSegment
	end
end

function Argument:GetTransformedValue(segment: number): any
	return unpack(self.TransformedValues[segment])
end

function Argument:Validate(isFinal: boolean?): (boolean, string?)
	if self.RawValue == nil or #self.RawValue == 0 and self.Required == false then
		return true
	end

	if self.Required and (self.RawSegments[1] == nil or #self.RawSegments[1] == 0) then
		return false, "This argument is required."
	end

	if self.Type.Validate or self.Type.ValidateOnce then
		for i = 1, #self.TransformedValues do
			if self.Type.Validate then
				local valid, errorText = self.Type.Validate(self:GetTransformedValue(i))

				if not valid then
					return valid, errorText or "Invalid value"
				end
			end

			if isFinal and self.Type.ValidateOnce then
				local validOnce, errorTextOnce = self.Type.ValidateOnce(self:GetTransformedValue(i))

				if not validOnce then
					return validOnce, errorTextOnce
				end
			end
		end

		return true
	else
		return true
	end
end

function Argument:GetAutocomplete(): { string }
	if self.Type.Autocomplete then
		return self.Type.Autocomplete(self:GetTransformedValue(#self.TransformedValues), self)
	else
		return {}
	end
end

function Argument:ParseValue(i: number): any
	if self.Type.Parse then
		return self.Type.Parse(self:GetTransformedValue(i))
	else
		return self:GetTransformedValue(i)
	end
end

function Argument:GetValue(): any
	if #self.RawValue == 0 and not self.Required and self.Object.Default ~= nil then
		return self.Object.Default
	end

	if not self.Type.Listable then
		return self:ParseValue(1)
	end

	local values = {}

	for i = 1, #self.TransformedValues do
		local parsedValue = self:ParseValue(i)

		if type(parsedValue) ~= "table" then
			error(`Listable types must return a table from Parse ({self.Type.Name})`)
		end

		for _, value in ipairs(parsedValue) do
			values[value] = true
		end
	end

	local valueArray = {}

	for value in pairs(values) do
		valueArray[#valueArray + 1] = value
	end

	return valueArray
end

function Argument:resolveKeywordResolver(keyword: string): ((any) -> { string })?
	if not self.Type.Selectors or not self.Type.Selectors.Keyword then
		return nil
	end

	local seen: { [string]: boolean } = {}
	local current = keyword

	for _ = 1, Config.Argument.KeywordResolverMaxDepth do
		if seen[current] then
			return nil
		end
		seen[current] = true

		local resolver = self.Type.Selectors.Keyword[current]
		if resolver == nil then
			return nil
		end
		if type(resolver) == "function" then
			return resolver
		end
		current = resolver
	end

	return nil
end

function Argument:resolveSelectorTerm(term: string, negated: boolean): { [string]: boolean }
	if #term == 0 then
		return {}
	end

	local resolver = self:resolveKeywordResolver(term)
	if resolver then
		local names = resolver(self.Executor)
		local nameSet: { [string]: boolean } = {}
		for _, name in ipairs(names) do
			nameSet[name] = true
		end
		if negated then
			return Set.complement(nameSet)
		end
		return nameSet
	end

	for _, patternInfo in ipairs(self.Type.Selectors.Pattern or {}) do
		local matches = { term:match(patternInfo.Pattern) }
		if #matches > 0 then
			local resolverFn = negated and patternInfo.Invert or patternInfo.Resolve
			if resolverFn then
				local names = resolverFn(self.Executor, matches)
				local nameSet: { [string]: boolean } = {}
				for _, name in ipairs(names) do
					nameSet[name] = true
				end
				return nameSet
			end
		end
	end

	local players = self:TransformSegment(term)
	local nameSet: { [string]: boolean } = {}
	for _, player in ipairs(players) do
		nameSet[player.Name] = true
	end

	if negated then
		return Set.complement(nameSet)
	end

	return nameSet
end

function Argument:parseCompoundTerms(segment: string): { { operator: string?, term: string, negated: boolean } }
	local terms: { { operator: string?, term: string, negated: boolean } } = {}
	local i = 1
	local len = #segment

	while i <= len do
		local operator = nil
		if #terms > 0 then
			local char = segment:sub(i, i)
			if char == "+" then
				operator = "+"
				i += 1
			elseif char == "-" then
				operator = "-"
				i += 1
			else
				break
			end
		end

		local negated = false
		local char = segment:sub(i, i)
		if char == "-" then
			negated = true
			i += 1
		elseif char == "+" then
			i += 1
		end

		local termText = ""
		while i <= len do
			local c = segment:sub(i, i)
			if c == "+" or c == "-" then
				break
			end
			termText = termText .. c
			i += 1
		end

		if #termText > 0 then
			table.insert(terms, {
				operator = operator,
				term = termText,
				negated = negated,
			})
		end
	end

	return terms
end

function Argument:resolveCompoundExpression(segment: string): { [string]: boolean }
	local terms = self:parseCompoundTerms(segment)

	if #terms == 0 then
		return {}
	end

	local result = self:resolveSelectorTerm(terms[1].term, terms[1].negated)

	for i = 2, #terms do
		local term = terms[i]
		local termSet = self:resolveSelectorTerm(term.term, term.negated)

		if term.operator == "+" then
			result = Set.intersection(result, termSet)
		else
			result = Set.difference(result, termSet)
		end
	end

	return result
end

function Argument:hasSelectorContent(rawValue: string): boolean
	if not self.Type.Selectors then
		return false
	end

	if rawValue:match("[%+%-]") then
		return true
	end

	local segments = String.splitStringSimple(rawValue, ",")
	for _, segment in ipairs(segments) do
		for keyword in pairs(self.Type.Selectors.Keyword) do
			if type(keyword) == "string" and segment == keyword then
				return true
			end
		end
		for _, patternInfo in ipairs(self.Type.Selectors.Pattern or {}) do
			if segment:match(patternInfo.Pattern) then
				return true
			end
		end
	end

	return false
end

function Argument:resolveSelectorValue(rawValue: string): string?
	if not self:hasSelectorContent(rawValue) then
		return nil
	end

	local segments = String.splitStringSimple(rawValue, ",")
	local resultSet: { [string]: boolean } = {}

	for _, segment in ipairs(segments) do
		local segmentSet = self:resolveCompoundExpression(segment)
		if next(segmentSet) then
			resultSet = Set.union(resultSet, segmentSet)
		end
	end

	local names: { string } = {}
	for name in pairs(resultSet) do
		table.insert(names, name)
	end

	if #names == 0 then
		return nil
	end

	return table.concat(names, ",")
end

return Argument
