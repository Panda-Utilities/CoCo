--!strict
return {
	Name = "userid";
	Aliases = {"id"};
	Description = "Show a player's user ID. Usage: userid <player>";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to check";
		};
	};

	ClientRun = function(context, target)
		context:reply(("%s's user ID: %d"):format(target.Name, target.UserId))
		return ("Checked %s's user ID."):format(target.Name)
	end;
}
