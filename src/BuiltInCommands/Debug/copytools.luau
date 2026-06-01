--!strict
return {
	Name = "copytools";
	Aliases = {};
	Description = "Copy all tools from a player.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to copy tools from";
		};
	};

	ClientRun = function(context, target)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local tChar = target.Character
		if not tChar then return "Target has no character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local copied = 0
		for _, v in ipairs(tChar:GetChildren()) do
			if v:IsA("Tool") then
				v.Archivable = true
				local clone = v:Clone()
				clone.Parent = character
				copied = copied + 1
			end
		end

		local backpack = target:FindFirstChild("Backpack")
		if backpack then
			for _, v in ipairs(backpack:GetChildren()) do
				if v:IsA("Tool") then
					v.Archivable = true
					local clone = v:Clone()
					clone.Parent = character
					copied = copied + 1
				end
			end
		end

		return ("Copied %d tool(s) from %s."):format(copied, target.Name)
	end;
}
