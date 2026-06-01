return {
	Name = "deletewaypoint";
	Aliases = {"dwp", "deleteposition", "deletepos"};
	Description = "Delete a saved waypoint.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = {
				Transform = function(text)
					return text
				end;
				Validate = function(value)
					return value ~= nil
				end;
				Parse = function(value)
					return tostring(value)
				end;
				Autocomplete = function(_, argument)
					local waypoints = argument.Registry:getStore("Waypoints")
					local names = {}
					for _, wp in pairs(waypoints) do
						table.insert(names, wp.name)
					end
					return names
				end;
			};
			Name = "name";
			Description = "Name of the waypoint to delete";
		};
	};

	ClientRun = function(context, name)
		local waypoints = context:getStore("Waypoints")
		local key = name:lower()
		local wp = waypoints[key]
		if not wp then return ("Waypoint \"%s\" not found."):format(name) end

		waypoints[key] = nil
		return ("Deleted waypoint \"%s\"."):format(wp.name)
	end;
}
