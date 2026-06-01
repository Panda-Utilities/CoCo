local Services = require("../../Shared/Services")
local RunService = Services.RunService

local autojumpEnabled = false
local autojumpLoop = nil
local autojumpCharCon = nil

local function stopAutojump()
	if autojumpLoop then
		autojumpLoop:Disconnect()
		autojumpLoop = nil
	end
	if autojumpCharCon then
		autojumpCharCon:Disconnect()
		autojumpCharCon = nil
	end
	autojumpEnabled = false
end

return {
	Name = "autojump";
	Aliases = {"ajump"};
	InverseAliases = {"unautojump", "noautojump"};
	Description = "Toggle auto jump (jump when hitting an obstacle).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not autojumpEnabled then return "Auto jump already disabled." end
			stopAutojump()
			return "Auto jump disabled."
		end

		if autojumpEnabled then
			stopAutojump()
			return "Auto jump disabled."
		end

		autojumpEnabled = true

		local function startLoop(char)
			if autojumpLoop then
				autojumpLoop:Disconnect()
			end

			local humanoid = char and char:FindFirstChildWhichIsA("Humanoid")
			local root = humanoid and humanoid.RootPart
			if not root or not humanoid then return end

			autojumpLoop = RunService.RenderStepped:Connect(function()
				if not autojumpEnabled then return end

				local c = context.Executor.Character
				local h = c and c:FindFirstChildWhichIsA("Humanoid")
				local r = h and h.RootPart
				if not r or not h then return end

				local origin = r.Position - Vector3.new(0, 1.5, 0)
				local dir = r.CFrame.LookVector * 3
				local hit = workspace:Raycast(origin, dir)
				if hit then
					h.Jump = true
				end
			end)
		end

		startLoop(context.Executor.Character)

		autojumpCharCon = context.Executor.CharacterAdded:Connect(function(char)
			char:WaitForChild("Humanoid")
			startLoop(char)
		end)

		return "Auto jump enabled."
	end;
}
