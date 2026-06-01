--!strict
local savedGravity = nil

return {
	Name = "gravity";
	Aliases = {"grav"};
	Description = "Set workspace gravity (or toggle default).";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "value";
			Description = "Gravity value (e.g. 50, 196.2) or 0 for none";
			Default = 196.2;
			Optional = true;
		};
	};

	ClientRun = function(_, value)
		if savedGravity ~= nil and (value == nil or value == savedGravity or value == 196.2) then
			workspace.Gravity = savedGravity
			savedGravity = nil
			return "Gravity restored."
		end

		if savedGravity == nil then
			savedGravity = workspace.Gravity
		end

		workspace.Gravity = value
		return ("Gravity set to %g."):format(value)
	end;
}
