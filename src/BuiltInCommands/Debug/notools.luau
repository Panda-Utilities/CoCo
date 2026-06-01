--!strict
return {
	Name = "notools";
	Aliases = {"rtools"};
	Description = "Remove all tools from your character.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local removed = 0
		for _, v in ipairs(character:GetChildren()) do
			if v:IsA("Tool") then
				v:Destroy()
				removed = removed + 1
			end
		end

		local backpack = context.Executor:FindFirstChild("Backpack")
		if backpack then
			for _, v in ipairs(backpack:GetChildren()) do
				if v:IsA("Tool") then
					v:Destroy()
					removed = removed + 1
				end
			end
		end

		return ("Removed %d tool(s)."):format(removed)
	end;
}
