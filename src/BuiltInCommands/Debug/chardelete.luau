--!strict
return {
	Name = "chardelete";
	Aliases = {"cd"};
	Description = "Delete a player's character.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player whose character to delete";
		};
	};

	ClientRun = function(_, target)
		local tChar = target.Character
		if not tChar then return "Target has no character." end

		local humanoid = tChar:FindFirstChildWhichIsA("Humanoid")
		if humanoid then
			humanoid:Destroy()
		end

		tChar:Destroy()
		return ("Deleted %s's character."):format(target.Name)
	end;
}
