--!strict

return {
	Name = "synsaveinstance";
	Aliases = { "saveinstance", "save", "download" };
	Description = "Run SynSaveInstance.";
	Group = "DefaultScripts";
	Args = {
	};

	ClientRun = function(context, query)
	    loadstring(game:HttpGet("https://raw.githubusercontent.com/Panda-Utilities/Storage/refs/heads/main/SaveInstance.lua"))()
		return "Executed SynSaveInstance"
	end;
}
