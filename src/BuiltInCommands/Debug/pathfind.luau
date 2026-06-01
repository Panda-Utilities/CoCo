--!strict
local Services = require("../../Shared/Services")
local PathfindingService = Services.PathfindingService
local RunService = Services.RunService

local pathfindTarget = nil
local pathfindConn = nil
local pathfindDied = nil

local function stopPathfind(context)
	if pathfindConn then
		pathfindConn:Disconnect()
		pathfindConn = nil
	end
	if pathfindDied then
		pathfindDied:Disconnect()
		pathfindDied = nil
	end
	pathfindTarget = nil

	local char = context.Executor.Character
	local hum = char and char:FindFirstChildWhichIsA("Humanoid")
	if hum and hum.RootPart then
		hum:MoveTo(hum.RootPart.Position)
	end
end

return {
	Name = "pathfind",
	Aliases = { "pathfindto", "pathfindfollow" },
	InverseAliases = { "unpathfind", "nopathfind" },
	Description = "Toggle pathfinding to a player (walks around obstacles). Usage: pathfind <player>",
	Group = "DefaultDebug",
	Args = {
		{
			Type = "player",
			Name = "target",
			Description = "The player to pathfind to",
			Optional = true,
		},
	},

	ClientRun = function(context, target)
		if context:isInvertedCall() then
			if not pathfindConn then return "Pathfind already disabled." end
			stopPathfind(context)
			return "Pathfind stopped."
		end

		if pathfindConn then
			stopPathfind(context)
			return "Pathfind stopped."
		end

		if not target then return "Usage: pathfind <player>" end

		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		pathfindTarget = target

		pathfindDied = humanoid.Died:Connect(function()
			stopPathfind(context)
		end)

		pathfindConn = RunService.RenderStepped:Connect(function()
			local char = context.Executor.Character
			if not char then return end
			local hum = char:FindFirstChildWhichIsA("Humanoid")
			if not hum then return end
			local root = hum.RootPart
			if not root then return end

			local tChar = pathfindTarget.Character
			if not tChar then return end
			local tHum = tChar:FindFirstChildWhichIsA("Humanoid")
			if not tHum then return end
			local tRoot = tHum.RootPart
			if not tRoot then return end

			local path = PathfindingService:CreatePath({
				AgentRadius = 2,
				AgentHeight = 5,
				AgentCanJump = true,
			})

			local success = pcall(function()
				path:ComputeAsync(root.Position, tRoot.Position)
			end)

			if success and path.Status == Enum.PathStatus.Success then
				local waypoints = path:GetWaypoints()
				if #waypoints > 0 then
					hum:MoveTo(waypoints[math.min(#waypoints, 2)].Position)
				end
			end
		end)

		return ("Now pathfinding to %s."):format(target.Name)
	end,
}
