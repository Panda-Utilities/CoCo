--!strict
local sitwalkEnabled = false
local origAnimIds = {}
local origHipHeight = nil

local function isR15(character)
	local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
	return humanoid and humanoid.RigType == Enum.HumanoidRigType.R15
end

return {
	Name = "sitwalk";
	Aliases = {};
	Description = "Toggle sitwalk (all animations become sit).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local anims = character:FindFirstChild("Animate")
		if not anims then return "No Animate script found." end

		local sitAnim = anims:FindFirstChild("sit")
		if not sitAnim then return "No sit animation found." end

		local sitAnimObj = sitAnim:FindFirstChildWhichIsA("Animation")
		if not sitAnimObj then return "No sit animation ID found." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		sitwalkEnabled = not sitwalkEnabled

		local folders = { "idle", "walk", "run", "jump" }

		if sitwalkEnabled then
			local sitId = sitAnimObj.AnimationId

			for _, name in ipairs(folders) do
				local folder = anims:FindFirstChild(name)
				if folder then
					local anim = folder:FindFirstChildWhichIsA("Animation")
					if anim then
						origAnimIds[name] = anim.AnimationId
						anim.AnimationId = sitId
					end
				end
			end

			origHipHeight = humanoid.HipHeight
			humanoid.HipHeight = isR15(character) and 0.5 or -1.5

			return "Sitwalk enabled."
		end

		for _, name in ipairs(folders) do
			local folder = anims:FindFirstChild(name)
			if folder then
				local anim = folder:FindFirstChildWhichIsA("Animation")
				if anim and origAnimIds[name] then
					anim.AnimationId = origAnimIds[name]
				end
			end
		end

		if origHipHeight then
			humanoid.HipHeight = origHipHeight
			origHipHeight = nil
		end

		return "Sitwalk disabled."
	end;
}
