return {
	Name = "fireproximityprompts";
	Aliases = {"firepp"};
	Description = "Fire all ProximityPrompts within range.";
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
			if v:IsA("ProximityPrompt") then
				local part = v.Parent
				if part and part:IsA("BasePart") then
					local dist = (part.Position - pos).Magnitude
					if dist <= v.MaxActivationDistance then
						v:InputHoldBegin()
						task.wait()
						v:InputHoldEnd()
						fired = fired + 1
					end
				end
			end
		end

		return ("Fired %d proximity prompt(s)."):format(fired)
	end;
}
