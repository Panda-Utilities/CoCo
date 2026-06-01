--!strict
return {
	Name = "grabtools";
	Aliases = {};
	Description = "Steal tools from a player.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to grab tools from";
		};
	};

	ClientRun = function(context, target)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local tChar = target.Character
		if not tChar then return "Target has no character." end

		local grabbed = 0
		for _, v in ipairs(tChar:GetChildren()) do
			if v:IsA("Tool") then
				v.Parent = character
				grabbed = grabbed + 1
			end
		end

		local backpack = target:FindFirstChild("Backpack")
		if backpack then
			for _, v in ipairs(backpack:GetChildren()) do
				if v:IsA("Tool") then
					v.Parent = character
					grabbed = grabbed + 1
				end
			end
		end

		return ("Grabbed %d tool(s) from %s."):format(grabbed, target.Name)
	end;
}
