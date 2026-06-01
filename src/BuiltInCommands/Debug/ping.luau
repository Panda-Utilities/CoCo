--!strict
return {
	Name = "ping";
	Aliases = {"notifyping"};
	Description = "Display your network ping.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function()
		local stats = game:GetService("Stats")
		local ping = math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue())
		return ("Ping: %d ms"):format(ping)
	end;
}
