--!strict
return {
	Name = "age";
	Aliases = {};
	Description = "Show the account age of a player. Usage: age <player>";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to check";
		};
	};

	ClientRun = function(context, target)
		context:reply(("%s's account age: %d days"):format(target.Name, target.AccountAge))
		return ("Checked %s's age."):format(target.Name)
	end;
}
