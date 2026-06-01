--!strict
return {
	Name = "scare";
	Aliases = {"spook"};
	Description = "Teleport behind a player briefly. Usage: scare <player>";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to scare";
		};
	};

	ClientRun = function(context, target)
		local character = context.Executor.Character
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
		local root = humanoid and humanoid.RootPart
		if not root then return "You don't have a character with a root part." end

		local targetChar = target.Character
		local targetHumanoid = targetChar and targetChar:FindFirstChildWhichIsA("Humanoid")
		local targetRoot = targetHumanoid and targetHumanoid.RootPart
		if not targetRoot then return "Target has no character or root part." end

		if target == context.Executor then return "You can't scare yourself." end

		local oldPos = root.CFrame
		root.CFrame = targetRoot.CFrame + targetRoot.CFrame.LookVector * 2
		root.CFrame = CFrame.new(root.Position, targetRoot.Position)
		task.wait(0.5)
		root.CFrame = oldPos

		return ("Scared %s."):format(target.Name)
	end;
}
