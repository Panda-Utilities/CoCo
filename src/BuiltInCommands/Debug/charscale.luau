--!strict
return {
	Name = "charscale";
	Aliases = {"scale"};
	Description = "Scale your character size (0.1-10).";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "scale";
			Description = "Scale factor (default: 1)";
			Default = 1;
		};
	};

	ClientRun = function(context, scale)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end
		local root = humanoid.RootPart
		if not root then return "No root part found." end

		scale = math.clamp(scale, 0.1, 10)

		local rootCF = root.CFrame
		root.Size = root.Size * scale

		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") and part ~= root then
				local offset = rootCF:ToObjectSpace(part.CFrame)
				part.Size = part.Size * scale
				part.CFrame = rootCF * CFrame.new(offset.Position * scale) * offset.Rotation
			end
		end

		return ("Character scaled to %g."):format(scale)
	end;
}
