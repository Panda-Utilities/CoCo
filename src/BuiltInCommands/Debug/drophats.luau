return {
	Name = "drophats";
	Aliases = {"drophat"};
	Description = "Drop all worn hats/accessories.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local dropped = 0
		for _, v in ipairs(character:GetChildren()) do
			if v:IsA("Accessory") or v:IsA("Hat") then
				v.Parent = workspace
				dropped = dropped + 1
			end
		end

		return ("Dropped %d hat(s)."):format(dropped)
	end;
}
