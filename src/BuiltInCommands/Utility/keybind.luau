--!strict
return {
	Name = "keybind";
	Aliases = {"close", "open"};
	Description = "Changes the keybind used to open/close the command menu.";
	Group = "DefaultUtil";
	Args = {
		{
			Type = "userInput";
			Name = "Key";
			Description = "The key to bind the menu toggle to.";
		};
	};

	ClientRun = function(context, key)
		local coco = context.CoCo
		coco:setActivationKeys({key})

		local ConfigManager = require("../../Shared/ConfigManager")
		ConfigManager:setActivationKeys({key})

		return ("Menu keybind set to %s."):format(key.Name or tostring(key))
	end;
}
