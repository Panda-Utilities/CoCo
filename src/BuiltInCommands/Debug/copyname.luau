--!strict
return {
	Name = "copyname";
	Aliases = {"copyuser"};
	Description = "Copy a player's name. Usage: copyname <player>";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to copy the name of";
		};
	};

	ClientRun = function(context, target)
		pcall(setclipboard, target.Name)
		return ("Copied %s's name."):format(target.Name)
	end;
}
