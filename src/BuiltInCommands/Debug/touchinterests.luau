--!strict
return {
	Name = "touchinterests";
	Aliases = {};
	Description = "Fire TouchInterest on the part under your mouse.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function()
		local player = game:GetService("Players").LocalPlayer
		local char = player.Character
		if not char then return "You don't have a character." end

		local humanoid = char:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid." end

		local root = humanoid.RootPart
		if not root then return "No root part." end

		if not firetouchinterest then return "Your exploit does not support firetouchinterest." end

		local mouse = player:GetMouse()
		local target = mouse.Target
		if not target then return "No target under mouse." end

		local fired = 0
		for _, v in ipairs(target:GetDescendants()) do
			if v:IsA("TouchTransmitter") or v.ClassName == "TouchInterest" then
				local part = v.FindFirstAncestorWhichIsA and v:FindFirstAncestorWhichIsA("Part") or v:FindFirstAncestorOfClass("Part")
				if part then
					firetouchinterest(part, root, 0)
					task.wait()
					firetouchinterest(part, root, 1)
					fired = fired + 1
				end
			end
		end

		return ("Fired %d touch interest(s)."):format(fired)
	end;
}
