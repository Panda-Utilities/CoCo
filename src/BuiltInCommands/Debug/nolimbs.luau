return {
	Name = "nolimbs";
	Aliases = {"rlimbs"};
	Description = "Remove all character limbs.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local removed = 0
		for _, part in ipairs(character:GetChildren()) do
			if part:IsA("BasePart") and part.Name ~= "Head" then
				part:Destroy()
				removed = removed + 1
			end
		end

		return removed > 0 and ("Removed %d limb(s)."):format(removed) or "No limbs found."
	end;
}
