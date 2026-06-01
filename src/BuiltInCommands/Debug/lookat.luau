--!strict
return {
	Name = "lookat";
	Aliases = {};
	Description = "Point your camera at a player.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to look at";
		};
	};

	ClientRun = function(_, target)
		local targetChar = target.Character
		if not targetChar then return "Target has no character." end

		local head = targetChar:FindFirstChild("Head")
		if not head then return "Target has no head." end

		local cam = workspace.CurrentCamera
		cam.CFrame = CFrame.lookAt(cam.CFrame.p, head.Position)

		return ("Looking at %s."):format(target.Name)
	end;
}
