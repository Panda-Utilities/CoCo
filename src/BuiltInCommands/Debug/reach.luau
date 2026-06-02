local savedSizes = {}

return {
	Name = "reach";
	Aliases = {};
	InverseAliases = {"unreach", "noreach"};
	Description = "Extend melee reach by scaling tool handle. Usage: reach [size]";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "size";
			Description = "Handle size (default: 60, box shape)";
			Default = 60;
			Optional = true;
		};
	};

	ClientRun = function(context, size)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		if context:isInvertedCall() then
			local count = 0
			for _, data in pairs(savedSizes) do
				pcall(function()
					data.handle.Size = data.origSize
					data.tool.GripPos = data.origGrip
				end)
				count = count + 1
			end
			table.clear(savedSizes)

			local humanoid = character:FindFirstChildWhichIsA("Humanoid")
			if humanoid then
				humanoid:UnequipTools()
			end

			return count > 0 and "Reach reset." or "Reach was not active."
		end

		if size < 1 then size = 1 end

		if next(savedSizes) then
			for _, data in pairs(savedSizes) do
				pcall(function()
					data.handle.Size = data.origSize
					data.tool.GripPos = data.origGrip
				end)
			end
			table.clear(savedSizes)
		end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local found = 0
		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("Tool") then
				local handle = child:FindFirstChild("Handle")
				if handle and handle:IsA("BasePart") then
					savedSizes[child] = {
						tool = child;
						handle = handle;
						origSize = handle.Size;
						origGrip = child.GripPos;
					}
					handle.Massless = true
					handle.Size = Vector3.new(size, size, size)
					child.GripPos = Vector3.new(0, 0, 0)
					found = found + 1
				end
			end
		end

		humanoid:UnequipTools()

		return found > 0 and ("Reach applied to %d tool(s) (size=%g)."):format(found, size) or "No tools found in character."
	end;
}
