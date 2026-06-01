local R6_DANCES = {
	"27789359", "30196114", "248263260", "45834924",
	"33796059", "28488254", "52155728",
}

local R15_DANCES = {
	"3333432454", "4555808220", "4049037604", "4555782893",
	"10214311282", "10714010337", "10713981723", "10714372526",
	"10714076981", "10714392151", "11444443576",
}

local danceTrack = nil

return {
	Name = "dance";
	Aliases = {};
	InverseAliases = {"undance", "nodance"};
	Description = "Toggle a random dance animation.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not danceTrack then return "Not dancing." end
			danceTrack:Stop()
			danceTrack:Destroy()
			danceTrack = nil
			return "Dance stopped."
		end

		if danceTrack then
			danceTrack:Stop()
			danceTrack:Destroy()
			danceTrack = nil
			return "Dance stopped."
		end

		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local dances = humanoid.RigType == Enum.HumanoidRigType.R15 and R15_DANCES or R6_DANCES
		local animId = dances[math.random(#dances)]

		local animation = Instance.new("Animation")
		animation.AnimationId = "rbxassetid://" .. animId

		danceTrack = humanoid:LoadAnimation(animation)
		danceTrack.Looped = true
		danceTrack:Play()

		return "Dancing!"
	end;
}
