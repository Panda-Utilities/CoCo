--!strict
return {
	Name = "maxzoom";
	Aliases = {};
	Description = "Set the camera max zoom distance. Usage: maxzoom <distance>";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "distance";
			Description = "Max zoom distance (default 99999)";
			Optional = true;
		};
	};

	ClientRun = function(context, distance)
		distance = distance or 99999
		context.Executor.CameraMaxZoomDistance = distance
		return ("Max zoom set to %s."):format(tostring(distance))
	end;
}
