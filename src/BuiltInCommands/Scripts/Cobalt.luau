--!strict

return {
	Name = "remotespy";
	Aliases = { "rspy", "cobalt" };
	Description = "Run the 'Cobalt' remote spy.";
	Group = "DefaultScripts";
	Args = {
	};

	ClientRun = function(context, query)
	    loadstring(game:HttpGet("https://raw.githubusercontent.com/Panda-Utilities/Storage/refs/heads/main/Cobalt.luau"))()
		return "Executed Cobalt"
	end;
}
