return {
	Name = "handlekill";
	Aliases = {"hkill"};
	Description = "Kill a player by breaking their character's joints.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to kill";
		};
	};

	ClientRun = function(_, target)
		local targetChar = target.Character
		if not targetChar then return "Target has no character." end

		local humanoid = targetChar:FindFirstChildWhichIsA("Humanoid")
		if humanoid then
			humanoid.Health = 0
			return ("Killed %s."):format(target.Name)
		end

		targetChar:BreakJoints()
		return ("Killed %s."):format(target.Name)
	end;
}
