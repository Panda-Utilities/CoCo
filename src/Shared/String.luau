--!strict
local String = {}

local function escapePattern(str)
	return str:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%1")
end

local function charCode(n)
	return utf8.char(tonumber(n, 16))
end

function String.splitStringSimple(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end

	if sep:sub(1, 1) ~= "%" then
		sep = sep:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%1")
	end
	local t = {}
	local i = 1
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

function String.parseEscapeSequences(text)
	return text:gsub("\\(.)", {
		t = "\t",
		n = "\n",
	})
	:gsub("\\u(%x%x%x%x)", charCode)
	:gsub("\\x(%x%x)", charCode)
end

function String.encodeEscapedOperator(text, op)
	local escapedOp = op:gsub(".", function(c) return "%" .. c end)
	local escapedFirst = escapePattern(op:sub(1, 1))

	return text:gsub("(" .. escapedFirst .. "+)(" .. escapedOp .. ")", function(esc, op)
			return (esc:sub(1, #esc-1) .. op):gsub(".", function(char)
					return "\\u" .. string.format("%04x", string.byte(char), 16)
			end)
	end)
end

local OPERATORS = {"&&", "||", ";"}
function String.encodeEscapedOperators(text)
	for _, operator in ipairs(OPERATORS) do
		text = String.encodeEscapedOperator(text, operator)
	end

	return text
end

function String.splitString(text, max)
	max = max or math.huge
	local tokens = {}
	local buf = {}
	local inQuotes = false
	local quoteChar

	local i = 1
	while i <= #text do
		local char = text:sub(i, i)

		if char == "\\" then
			local next = text:sub(i + 1, i + 1)
			if next == "\n" or next == "n" then
				table.insert(buf, "\n")
				i = i + 2
			elseif next == "t" then
				table.insert(buf, "\t")
				i = i + 2
			elseif next == "u" then
				local hex = text:sub(i + 2, i + 5)
				if #hex == 4 and hex:match("^%x%x%x%x$") then
					table.insert(buf, utf8.char(tonumber(hex, 16)))
					i = i + 6
				else
					table.insert(buf, char)
					i = i + 1
				end
			elseif next == "x" then
				local hex = text:sub(i + 2, i + 3)
				if #hex == 2 and hex:match("^%x%x$") then
					table.insert(buf, utf8.char(tonumber(hex, 16)))
					i = i + 4
				else
					table.insert(buf, char)
					i = i + 1
				end
			elseif next ~= nil then
				table.insert(buf, next)
				i = i + 2
			else
				table.insert(buf, char)
				i = i + 1
			end
		elseif char == '"' or char == "'" then
			if not inQuotes then
				inQuotes = true
				quoteChar = char
			elseif char == quoteChar then
				inQuotes = false
			else
				table.insert(buf, char)
			end
			i = i + 1
		elseif char == " " then
			if inQuotes then
				table.insert(buf, char)
			else
				if #buf > 0 then
					local token = table.concat(buf)
					if #tokens < max then
						tokens[#tokens + 1] = token
					else
						tokens[max] = tokens[max] .. " " .. token
					end
					buf = {}
				end
			end
			i = i + 1
		else
			table.insert(buf, char)
			i = i + 1
		end
	end

	if #buf > 0 then
		tokens[#tokens + 1] = table.concat(buf)
	end

	return tokens
end

function String.mashExcessArguments(arguments, max)
	local t = {}
	for i = 1, #arguments do
		if i > max then
			t[max] = `{t[max] or ""} {arguments[i]}`
		else
			t[i] = arguments[i]
		end
	end
	return t
end

function String.trimString(str)
	local _, from = string.find(str, "^%s*")
	return from == #str and "" or string.match(str, ".*%S", from + 1)
end

function String.emulateTabstops(text, tabWidth)
	local column = 0
	local textLength = #text
	local result = table.create(textLength)
	for i = 1, textLength do
		local char = string.sub(text, i, i)
		if char == "\t" then
			local spaces = tabWidth - column % tabWidth
			table.insert(result, string.rep(" ", spaces))
			column += spaces
		else
			table.insert(result, char)
			if char == "\n" then
				column = 0
			elseif char ~= "\r" then
				column += 1
			end
		end
	end
	return table.concat(result)
end

return String
