return {
	Name = "gotopart";
	Aliases = {"topart"};
	Description = "Teleport to a part by name in workspace.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "string";
			Name = "partName";
			Description = "Name of the part to teleport to";
		};
	};

	ClientRun = function(context, partName)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local root = humanoid.RootPart
		if not root then return "No root part." end

		local found = nil
		for _, v in ipairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") and v.Name:lower() == partName:lower() then
				found = v
				break
			end
		end

		if not found then
			return ("No part named %q found."):format(partName)
		end

		root.CFrame = found.CFrame * CFrame.new(0, 3, 0)
		return ("Teleported to %s."):format(found:GetFullName())
	end;
}
