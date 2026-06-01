--!strict
return {
	Name = "droptools";
	Aliases = {};
	Description = "Drop all held tools.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local dropped = 0
		for _, v in ipairs(character:GetChildren()) do
			if v:IsA("Tool") then
				humanoid:UnequipTools()
				v.Parent = workspace
				dropped = dropped + 1
			end
		end

		return ("Dropped %d tool(s)."):format(dropped)
	end;
}
