--!strict
return {
	Name = "datalimit";
	Aliases = {};
	Description = "Set outgoing KBPS data limit. Usage: datalimit <kbps> | datalimit (disables)";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "kbps";
			Description = "Outgoing data limit in KB/s";
			Optional = true;
		};
	};

	ClientRun = function(context, kbps)
		local networkClient = game:GetService("NetworkClient")
		local limit = kbps or 0
		networkClient:SetOutgoingKBPSLimit(limit)
		if limit > 0 then
			return ("Data limit set to %d KB/s."):format(limit)
		end
		return "Data limit disabled."
	end;
}
