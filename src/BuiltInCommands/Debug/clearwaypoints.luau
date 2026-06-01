return {
	Name = "clearwaypoints";
	Aliases = {"cwp", "clearpositions", "clearpos"};
	Description = "Delete all saved waypoints.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local waypoints = context:getStore("Waypoints")
		local count = 0
		for k, _ in waypoints do
			waypoints[k] = nil
			count = count + 1
		end
		return ("Cleared %d waypoint(s)."):format(count)
	end;
}
