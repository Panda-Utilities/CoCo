--!strict

return {
	Name = "dex";
	Aliases = { "dex++", "dexplusplus" };
	Description = "Run the 'Dex++' version of Dex.";
	Group = "DefaultScripts";
	Args = {
	};

	ClientRun = function(context, query)
	    loadstring(game:HttpGet("https://raw.githubusercontent.com/Panda-Utilities/Storage/refs/heads/main/Dex%2B%2B.lua"))()
		return "Executed Dex++"
	end;
}
