--!strict
local Services = require("../../Shared/Services")

local frozen = {}

return {
	Name = "freeze";
	Aliases = {"fr"};
	Description = "Toggle freeze a player (anchors all their parts).";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to freeze/thaw";
		};
	};

	ClientRun = function(context, target)
		local targetChar = target.Character
		if not targetChar then return "Target has no character." end

		if frozen[target] then
			for _, x in ipairs(targetChar:GetDescendants()) do
				if x:IsA("BasePart") and x.Anchored then
					x.Anchored = false
				end
			end
			frozen[target] = nil
			return ("%s thawed."):format(target.Name)
		else
			for _, x in ipairs(targetChar:GetDescendants()) do
				if x:IsA("BasePart") and not x.Anchored then
					x.Anchored = true
				end
			end
			frozen[target] = true
			return ("%s frozen."):format(target.Name)
		end
	end;
}
