--!strict
return {
	Name = "nobgui";
	Aliases = {"rohg", "nobillboardgui", "noname"};
	Description = "Remove all BillboardGuis and SurfaceGuis from your character.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local removed = 0
		for _, v in ipairs(character:GetDescendants()) do
			if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
				v:Destroy()
				removed = removed + 1
			end
		end

		return ("Removed %d GUI(s)."):format(removed)
	end;
}
