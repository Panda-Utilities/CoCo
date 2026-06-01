--!strict
return {
	Name = "waypoint";
	Aliases = {"wp", "loadposition", "loadpos"};
	Description = "Teleport to a saved waypoint.";
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
			Description = "Name of the waypoint";
		};
	};

	ClientRun = function(context, name)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid." end

		local root = humanoid.RootPart
		if not root then return "No root part." end

		local waypoints = context:getStore("Waypoints")
		local wp = waypoints[name:lower()]
		if not wp then return ("Waypoint \"%s\" not found."):format(name) end

		root.CFrame = CFrame.new(wp.x, wp.y, wp.z)
		return ("Teleported to waypoint \"%s\" (%d, %d, %d)."):format(wp.name, wp.x, wp.y, wp.z)
	end;
}
