--!strict

return {
	Name = "sigmaspy";
	Aliases = { "ss", "rspys" };
	Description = "Run the 'Sigma Spy' remote spy.";
	Group = "DefaultScripts";
	Args = {
	};

	ClientRun = function(context, query)
	    loadstring(game:HttpGet("https://raw.githubusercontent.com/panduh16/Sigma-Spy/refs/heads/main/Main.lua"))()
		return "Executed Sigma Spy"
	end;
}
