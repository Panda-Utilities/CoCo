return {
	Name = "breakloops";
	Aliases = {};
	Description = "Stop all running command loops.";
	Group = "DefaultDebug";
	Args = {};

	Run = function(context)
		local count = context.Dispatcher:breakLoops()
		return `Cancelled {count} running loop(s).`
	end;
}
