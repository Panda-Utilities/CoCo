--!strict
local Services = require("./Services")
local Players = Services.Players

local PlayerSelectors = {}

function PlayerSelectors.getCharacterPosition(character)
	if not character then
		return nil
	end

	local root = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")

	if root then
		return root.Position
	end

	return nil
end

PlayerSelectors.ArgumentOperatorAliases = {
	me = ".",
	all = "*",
	others = "**",
	random = "?",
}

PlayerSelectors.Selectors = {
	Keyword = {
		allies = function(executor)
			local team = executor.Team
			if not team then return {} end
			local names = {}
			for _, player in ipairs(Players:GetPlayers()) do
				if player.Team == team then
					table.insert(names, player.Name)
				end
			end
			return names
		end,
		team = "allies",
		enemies = function(executor)
			local team = executor.Team
			local names = {}
			for _, player in ipairs(Players:GetPlayers()) do
				if not team or player.Team ~= team then
					table.insert(names, player.Name)
				end
			end
			return names
		end,
		nonteam = "enemies",
		friends = function(executor)
			local ok, pages = pcall(function()
				return Players:GetFriendsAsync(executor.UserId)
			end)
			if not ok then return {} end
			local friendUserIds = {}
			pcall(function()
				while true do
					local page = pages:GetCurrentPage()
					for _, friendInfo in ipairs(page) do
						friendUserIds[friendInfo.Id] = true
					end
					if pages:IsFinished() then break end
					pages:AdvanceToNextPageAsync()
				end
			end)
			local names = {}
			for _, player in ipairs(Players:GetPlayers()) do
				if friendUserIds[player.UserId] then
					table.insert(names, player.Name)
				end
			end
			return names
		end,
		nonfriends = function(executor)
			local ok, pages = pcall(function()
				return Players:GetFriendsAsync(executor.UserId)
			end)
			if not ok then
				local allNames = {}
				for _, player in ipairs(Players:GetPlayers()) do
					table.insert(allNames, player.Name)
				end
				return allNames
			end
			local friendUserIds = {}
			pcall(function()
				while true do
					local page = pages:GetCurrentPage()
					for _, friendInfo in ipairs(page) do
						friendUserIds[friendInfo.Id] = true
					end
					if pages:IsFinished() then break end
					pages:AdvanceToNextPageAsync()
				end
			end)
			local names = {}
			for _, player in ipairs(Players:GetPlayers()) do
				if not friendUserIds[player.UserId] then
					table.insert(names, player.Name)
				end
			end
			return names
		end,
		nearest = function(executor)
			local position = PlayerSelectors.getCharacterPosition(executor.Character)
			if not position then return {} end
			local nearestDist = math.huge
			local nearestName = nil
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= executor then
					local otherPos = PlayerSelectors.getCharacterPosition(player.Character)
					if otherPos then
						local dist = (otherPos - position).Magnitude
						if dist < nearestDist then
							nearestDist = dist
							nearestName = player.Name
						end
					end
				end
			end
			if nearestName then return { nearestName } end
			return {}
		end,
		farthest = function(executor)
			local position = PlayerSelectors.getCharacterPosition(executor.Character)
			if not position then return {} end
			local farthestDist = -1
			local farthestName = nil
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= executor then
					local otherPos = PlayerSelectors.getCharacterPosition(player.Character)
					if otherPos then
						local dist = (otherPos - position).Magnitude
						if dist > farthestDist then
							farthestDist = dist
							farthestName = player.Name
						end
					end
				end
			end
			if farthestName then return { farthestName } end
			return {}
		end,
		furthest = "farthest",
		alive = function(_)
			local names = {}
			for _, player in ipairs(Players:GetPlayers()) do
				local humanoid = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
				if humanoid and humanoid.Health > 0 then
					table.insert(names, player.Name)
				end
			end
			return names
		end,
		dead = function(_)
			local names = {}
			for _, player in ipairs(Players:GetPlayers()) do
				local humanoid = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
				if not humanoid or humanoid.Health <= 0 then
					table.insert(names, player.Name)
				end
			end
			return names
		end,
		cursor = function(_)
			local localPlayer = Services.Players.LocalPlayer
			local mouse = localPlayer and localPlayer:GetMouse()
			if not mouse then return {} end
			local mousePos = mouse.Hit.Position
			local closestDist = math.huge
			local closestName = nil
			for _, player in ipairs(Players:GetPlayers()) do
				local pos = PlayerSelectors.getCharacterPosition(player.Character)
				if pos then
					local dist = (pos - mousePos).Magnitude
					if dist < closestDist then
						closestDist = dist
						closestName = player.Name
					end
				end
			end
			if closestName then return { closestName } end
			return {}
		end,
		npcs = function(_)
			local names = {}
			for _, descendant in ipairs(Services.Workspace:GetDescendants()) do
				if not descendant:IsA("Player") then
					local humanoid = descendant:FindFirstChildWhichIsA("Humanoid")
					if humanoid and descendant.Parent then
						local npcName = humanoid.Parent.Name
						if not Players:FindFirstChild(npcName) then
							table.insert(names, npcName)
						end
					end
				end
			end
			return names
		end,
	},
	Pattern = {
		{
			Pattern = "^age(%d+)$",
			Resolve = function(_, matches)
				local maxAge = tonumber(matches[1])
				local names = {}
				for _, player in ipairs(Players:GetPlayers()) do
					if player.AccountAge <= maxAge then
						table.insert(names, player.Name)
					end
				end
				return names
			end,
			Invert = function(_, matches)
				local maxAge = tonumber(matches[1])
				local names = {}
				for _, player in ipairs(Players:GetPlayers()) do
					if player.AccountAge > maxAge then
						table.insert(names, player.Name)
					end
				end
				return names
			end,
		},
		{
			Pattern = "^rad(%d+)$",
			Resolve = function(executor, matches)
				local radius = tonumber(matches[1])
				local position = PlayerSelectors.getCharacterPosition(executor.Character)
				if not position then return {} end
				local names = {}
				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= executor then
						local otherPos = PlayerSelectors.getCharacterPosition(player.Character)
						if otherPos and (otherPos - position).Magnitude <= radius then
							table.insert(names, player.Name)
						end
					end
				end
				return names
			end,
			Invert = function(executor, matches)
				local radius = tonumber(matches[1])
				local position = PlayerSelectors.getCharacterPosition(executor.Character)
				if not position then return {} end
				local names = {}
				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= executor then
						local otherPos = PlayerSelectors.getCharacterPosition(player.Character)
						if not otherPos or (otherPos - position).Magnitude > radius then
							table.insert(names, player.Name)
						end
					end
				end
				return names
			end,
		},
		{
			Pattern = "^group(%d+)$",
			Resolve = function(_, matches)
				local groupId = tonumber(matches[1])
				local names = {}
				for _, player in ipairs(Players:GetPlayers()) do
					if player:IsInGroup(groupId) then
						table.insert(names, player.Name)
					end
				end
				return names
			end,
			Invert = function(_, matches)
				local groupId = tonumber(matches[1])
				local names = {}
				for _, player in ipairs(Players:GetPlayers()) do
					if not player:IsInGroup(groupId) then
						table.insert(names, player.Name)
					end
				end
				return names
			end,
		},
		{
			Pattern = "^#(%d+)$",
			Resolve = function(_, matches)
				local count = tonumber(matches[1])
				local allPlayers = Players:GetPlayers()
				if #allPlayers == 0 then return {} end
				local indices = {}
				for i = 1, #allPlayers do
					indices[i] = i
				end
				local actual = math.min(count, #allPlayers)
				local names = {}
				for _ = 1, actual do
					local chosen = math.random(1, #indices)
					table.insert(names, allPlayers[table.remove(indices, chosen)].Name)
				end
				return names
			end,
			Invert = function(_, matches)
				local count = tonumber(matches[1])
				local allPlayers = Players:GetPlayers()
				if #allPlayers == 0 then return {} end
				local indices = {}
				for i = 1, #allPlayers do
					indices[i] = i
				end
				local actual = math.min(count, #allPlayers)
				local excluded = {}
				for _ = 1, actual do
					local chosen = math.random(1, #indices)
					excluded[allPlayers[table.remove(indices, chosen)].Name] = true
				end
				local names = {}
				for _, player in ipairs(allPlayers) do
					if not excluded[player.Name] then
						table.insert(names, player.Name)
					end
				end
				return names
			end,
		},
	},
}

function PlayerSelectors.buildAutocomplete(items, argument)
	local options = {}
	local hadNonPlayerItem = false

	if argument then
		local typedText = (argument.TextSegmentInProgress or ""):lower()

		local seen = {}
		for _, item in ipairs(items) do
			seen[item:lower()] = true
		end

		if argument.Type.ArgumentOperatorAliases then
			for alias in pairs(argument.Type.ArgumentOperatorAliases) do
				if type(alias) == "string" then
					local lower = alias:lower()
					local mapped = argument.Type.ArgumentOperatorAliases[alias]
					if typedText ~= "" and (lower:sub(1, #typedText) == typedText or (mapped and typedText:sub(1, #mapped) == mapped)) and not seen[lower] then
						if alias == "me" or alias == "random" or argument.Type.Listable then
							table.insert(items, alias)
							seen[lower] = true
							hadNonPlayerItem = true
						elseif alias == "all" or alias == "others" then
							local allPlayers = Players:GetPlayers()
							local executorName = argument.Executor and argument.Executor.Name
							for _, player in ipairs(allPlayers) do
								if alias ~= "others" or not executorName or player.Name ~= executorName then
									local playerLower = player.Name:lower()
									if not seen[playerLower] then
										table.insert(items, player.Name)
										seen[playerLower] = true
									end
								end
							end
							hadNonPlayerItem = true
						end
					end
				end
			end
		end

		if argument.Type.Selectors then
			if argument.Type.Selectors.Keyword then
				for keyword in pairs(argument.Type.Selectors.Keyword) do
					if type(keyword) == "string" then
						local lower = keyword:lower()
						if typedText ~= "" and lower:sub(1, #typedText) == typedText and not seen[lower] then
							local resolver = argument:resolveKeywordResolver(keyword)
							if resolver then
								local names = resolver(argument.Executor)
								if #names > 0 then
									if not argument.Type.Listable then
										for _, name in ipairs(names) do
											local nameLower = name:lower()
											if not seen[nameLower] then
												table.insert(items, name)
												seen[nameLower] = true
											end
										end
									else
										table.insert(items, keyword)
										seen[lower] = true
									end
									hadNonPlayerItem = true
								end
							end
						end
					end
				end
			end

			if argument.Type.Selectors.Pattern then
				for _, patternInfo in ipairs(argument.Type.Selectors.Pattern) do
					local patternName = patternInfo.Pattern:match("^%^([a-z]+)%(")
					if patternName then
						if typedText ~= "" and patternName:sub(1, #typedText) == typedText and not seen[patternName] then
							table.insert(items, patternName .. "#")
							seen[patternName] = true
							hadNonPlayerItem = true
						end
					end
				end
			end
		end

		if hadNonPlayerItem and #typedText > 0 then
			options.IsPartial = true
		end
	end

	return items, options
end

return PlayerSelectors
