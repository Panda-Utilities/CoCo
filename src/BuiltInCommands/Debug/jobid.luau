return {
	Name = "jobid";
	Aliases = {};
	Description = "Copy the current job ID to clipboard.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function()
		local suc, err = pcall(setclipboard, game.JobId)
		if suc then
			return ("Job ID copied: %s"):format(game.JobId)
		end
		return ("Job ID: %s"):format(game.JobId)
	end;
}
