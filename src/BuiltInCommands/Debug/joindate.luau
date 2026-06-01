return {
	Name = "joindate";
	Aliases = {"jd"};
	Description = "Show the join date of a player. Usage: joindate <player>";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to check";
		};
	};

	ClientRun = function(context, target)
		local secondsOld = target.AccountAge * 24 * 60 * 60
		local dateJoined = os.date("%m/%d/%y", os.time() - secondsOld)
		context:reply(("%s joined: %s"):format(target.Name, dateJoined))
		return ("Checked %s's join date."):format(target.Name)
	end;
}
