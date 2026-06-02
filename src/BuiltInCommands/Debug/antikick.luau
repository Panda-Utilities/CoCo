local antiKickActive = false
local oldKickFn = nil
local oldIndex = nil
local oldNamecall = nil

local function restore()
	if oldKickFn then
		pcall(function()
			game:GetService("Players").LocalPlayer.Kick = oldKickFn
		end)
		oldKickFn = nil
	end

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

	antiKickActive = false
end

return {
	Name = "antikick";
	Aliases = {"clientantikick"};
	InverseAliases = {"unantikick", "noantikick"};
	Description = "Toggle anti-kick (blocks localscript kick attempts).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not antiKickActive then return "Anti-kick already disabled." end
			restore()
			return "Anti-kick disabled."
		end

		if antiKickActive then
			restore()
			return "Anti-kick disabled."
		end

		local LocalPlayer = context.Executor

		pcall(function()
			oldKickFn = hookfunction(LocalPlayer.Kick, function() end)
		end)

		pcall(function()
			local oldIdx
			oldIdx = hookmetamethod(game, "__index", function(self, method)
				if self == LocalPlayer and method:lower() == "kick" then
					return error("Expected ':' not '.' calling member function Kick", 2)
				end
				return oldIdx(self, method)
			end)
			oldIndex = oldIdx
		end)

		pcall(function()
			local oldNc
			oldNc = hookmetamethod(game, "__namecall", function(self, ...)
				if self == LocalPlayer and getnamecallmethod():lower() == "kick" then
					return
				end
				return oldNc(self, ...)
			end)
			oldNamecall = oldNc
		end)

		if getconnections then
			local kickedEvent = LocalPlayer:FindFirstChild("Kicked")
			if kickedEvent and kickedEvent:IsA("BindableEvent") then
				for _, conn in ipairs(getconnections(kickedEvent)) do
					pcall(function() conn:Disconnect() end)
				end
			end
		end

		antiKickActive = true
		return "Anti-kick enabled."
	end;
}
