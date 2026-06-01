--!strict
local Services = require("../../Shared/Services")
local TweenService = Services.TweenService

return {
	Name = "tweengoto";
	Aliases = {"tgoto", "tto", "tweento", "ttp"};
	Description = "Tween to a player. Usage: tweengoto <player> [speed]";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to tween to";
		};
		{
			Type = "number";
			Name = "speed";
			Description = "Tween speed in seconds (default 1)";
			Optional = true;
		};
	};

	ClientRun = function(context, target, speed)
		local character = context.Executor.Character
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
		local root = humanoid and humanoid.RootPart
		if not root then return "You don't have a root part." end

		local targetChar = target.Character
		local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
		if not targetRoot then return "Target has no humanoid root part." end

		speed = speed or 1

		local tween = TweenService:Create(root, TweenInfo.new(speed, Enum.EasingStyle.Linear), {
			CFrame = targetRoot.CFrame * CFrame.new(0, 3, 0)
		})
		tween:Play()

		return ("Tweening to %s."):format(target.Name)
	end;
}
