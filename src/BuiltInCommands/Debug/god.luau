local Services = require("../../Shared/Services")

local godActive = false
local savedHuman = nil

local function disableGod(context)
	if savedHuman then
		local character = context.Executor.Character
		if character then
			local humanoid = character:FindFirstChildWhichIsA("Humanoid")
			if humanoid then
				humanoid:Destroy()
			end
			savedHuman.Parent = character
			context.Executor.Character = character
			local cam = workspace.CurrentCamera
			cam.CameraSubject = savedHuman
			cam.CFrame = cam.CFrame

			local animate = character:FindFirstChild("Animate")
			if animate then
				animate.Disabled = true
				task.wait()
				animate.Disabled = false
			end
		end
	end
	godActive = false
	savedHuman = nil
end

return {
	Name = "god";
	Aliases = {};
	InverseAliases = {"ungod"};
	Description = "Toggle god mode (invincible, disable death states).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not godActive then return "God mode already disabled." end
			disableGod(context)
			return "God mode disabled."
		end

		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		if godActive then
			disableGod(context)
			return "God mode disabled."
		end

		local cam = workspace.CurrentCamera
		local pos = cam.CFrame
		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local newHumanoid = humanoid:Clone()
		newHumanoid.Parent = character

		context.Executor.Character = nil
		newHumanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
		newHumanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
		newHumanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
		newHumanoid.BreakJointsOnDeath = true
		humanoid:Destroy()

		context.Executor.Character = character
		cam.CameraSubject = newHumanoid
		cam.CFrame = task.wait() and pos
		newHumanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

		local animate = character:FindFirstChild("Animate")
		if animate then
			animate.Disabled = true
			task.wait()
			animate.Disabled = false
		end

		newHumanoid.Health = newHumanoid.MaxHealth
		godActive = true
		savedHuman = newHumanoid

		return "God mode enabled."
	end;
}
