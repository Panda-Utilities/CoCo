return {
	Name = "setwaypoint";
	Aliases = {"swp", "saveposition", "savepos"};
	Description = "Save your current position as a named waypoint.";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "string";
			Name = "name";
			Description = "Name for the waypoint";
		};
	};

	ClientRun = function(context, name)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid." end

		local root = humanoid.RootPart
		if not root then return "No root part." end

		local pos = root.Position
		local waypoints = context:getStore("Waypoints")
		local key = name:lower()
		waypoints[key] = {
			name = name,
			x = math.floor(pos.X),
			y = math.floor(pos.Y),
			z = math.floor(pos.Z),
		}

		return ("Saved waypoint \"%s\" at (%d, %d, %d)."):format(name, waypoints[key].x, waypoints[key].y, waypoints[key].z)
	end;
}
