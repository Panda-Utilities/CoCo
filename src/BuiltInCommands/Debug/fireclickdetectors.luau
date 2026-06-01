--!strict
return {
	Name = "fireclickdetectors";
	Aliases = {"firecd"};
	Description = "Fire all ClickDetectors within 50 studs.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function()
		local player = game:GetService("Players").LocalPlayer
		local char = player.Character
		if not char then return "No character." end

		local root = char:FindFirstChildWhichIsA("Humanoid")
		root = root and root.RootPart
		if not root then return "No root part." end

		local pos = root.Position
		local fired = 0

		for _, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("ClickDetector") then
				local part = v.Parent
				if part and part:IsA("BasePart") then
					local dist = (part.Position - pos).Magnitude
					if dist <= 50 then
						v:Click(player:GetMouse().Hit.Position, player)
						fired = fired + 1
					end
				end
			end
		end

		return ("Fired %d click detector(s)."):format(fired)
	end;
}
