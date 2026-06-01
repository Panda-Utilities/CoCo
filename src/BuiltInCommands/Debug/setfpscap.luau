--!strict
local fpscaploop = nil

return {
	Name = "setfpscap";
	Aliases = {"fpscap", "maxfps"};
	Description = "Set a custom FPS cap. Usage: setfpscap <fps> | none";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "fps";
			Description = "FPS cap (e.g. 60, 144, 999)";
			Optional = true;
		};
	};

	ClientRun = function(context, fps)
		if fpscaploop then
			task.cancel(fpscaploop)
			fpscaploop = nil
		end

		if not fps or fps <= 0 then
			return "FPS cap disabled."
		end

		local cap = fps
		fpscaploop = task.spawn(function()
			local timer = os.clock()
			while true do
				if os.clock() >= timer + 1 / cap then
					timer = os.clock()
					task.wait()
				end
			end
		end)

		return ("FPS cap set to %d."):format(cap)
	end;
}
