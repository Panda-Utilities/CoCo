local antiTeleportActive = false
local oldIndex = nil
local oldNamecall = nil

local function restore()
	if oldIndex then
		pcall(function()
			hookmetamethod(game, "__index", oldIndex)
		end)
		oldIndex = nil
	end

	if oldNamecall then
		pcall(function()
			hookmetamethod(game, "__namecall", oldNamecall)
		end)
		oldNamecall = nil
	end

	antiTeleportActive = false
end

return {
	Name = "antiteleport";
	Aliases = {"clientantiteleport"};
	InverseAliases = {"unantiteleport", "noantiteleport"};
	Description = "Toggle anti-teleport (blocks localscript teleport attempts).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not antiTeleportActive then return "Anti-teleport already disabled." end
			restore()
			return "Anti-teleport disabled."
		end

		if antiTeleportActive then
			restore()
			return "Anti-teleport disabled."
		end

		local TeleportService = game:GetService("TeleportService")

		local success, idxResult = pcall(function()
			local oldIdx
			oldIdx = hookmetamethod(game, "__index", function(self, method)
				if self == TeleportService then
					local m = method:lower()
					if m == "teleport" then
						return error("Expected ':' not '.' calling member function Kick", 2)
					elseif method == "TeleportToPlaceInstance" then
						return error("Expected ':' not '.' calling member function TeleportToPlaceInstance", 2)
					end
				end
				return oldIdx(self, method)
			end)
			return oldIdx
		end)

		if not success then
			return "Anti-teleport not supported on this executor."
		end
		oldIndex = idxResult

		local success2, ncResult = pcall(function()
			local oldNc
			oldNc = hookmetamethod(game, "__namecall", function(self, ...)
				if self == TeleportService then
					local method = getnamecallmethod():lower()
					if method == "teleport" or method == "teleporttoplaceinstance" then
						return
					end
				end
				return oldNc(self, ...)
			end)
			return oldNc
		end)

		if not success2 then
			restore()
			return "Anti-teleport partially enabled (only __index hook)."
		end
		oldNamecall = ncResult

		antiTeleportActive = true
		return "Anti-teleport enabled."
	end;
}
