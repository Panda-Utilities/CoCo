local Services = require("../../Shared/Services")
local RunService = Services.RunService

local loopConnection = nil
local loopAnimId = nil

return {
	Name = "loopanimation";
	Aliases = {"loopanim"};
	Description = "Toggle looping an animation by ID.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "string";
			Name = "id";
			Description = "Animation ID to loop";
			Optional = true;
		};
	};

	ClientRun = function(context, id)
		if loopConnection then
			loopConnection:Disconnect()
			loopConnection = nil
			loopAnimId = nil
			return "Animation loop stopped."
		end

		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local animId = id and id:match("(%d+)")
		if not animId then return "Invalid animation ID." end

		loopAnimId = animId

		loopConnection = RunService.RenderStepped:Connect(function()
			local char = context.Executor.Character
			if not char then return end
			local hum = char:FindFirstChildWhichIsA("Humanoid")
			if not hum then return end

			local alreadyPlaying = false
			for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
				if track.Animation.AnimationId:match(loopAnimId) then
					alreadyPlaying = true
					break
				end
			end

			if not alreadyPlaying then
				local animation = Instance.new("Animation")
				animation.AnimationId = "rbxassetid://" .. loopAnimId
				local track = hum:LoadAnimation(animation)
				track:Play()
			end
		end)

		return ("Looping animation %s."):format(animId)
	end;
}
