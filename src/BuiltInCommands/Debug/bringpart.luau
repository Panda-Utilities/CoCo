--!strict
return {
	Name = "bringpart";
	Aliases = {};
	Description = "Bring a part to your position by name.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "string";
			Name = "partName";
			Description = "Name of the part to bring";
		};
	};

	ClientRun = function(context, partName)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local root = humanoid.RootPart
		if not root then return "No root part." end

		local found = 0
		for _, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") and v.Name:lower() == partName:lower() then
				v.CFrame = root.CFrame * CFrame.new(0, 5, -5)
				found = found + 1
			end
		end

		return ("Brought %d part(s) named %q."):format(found, partName)
	end;
}
