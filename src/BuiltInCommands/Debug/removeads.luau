local AD_NAMES = {
	"AdGui", "AdPortal", "AdService", "Advertisement",
	"Sponsored", "Promo", "Promotion", "VideoAd",
}

return {
	Name = "removeads";
	Aliases = {"adblock"};
	Description = "Remove in-game advertisements and sponsored content.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local removed = 0

		local coreGui = game:GetService("CoreGui")
		for _, name in AD_NAMES do
			local instances = coreGui:FindFirstChild(name, true)
			while instances do
				local nextInst = instances:FindFirstChild(name, true)
				pcall(function()
					instances:Destroy()
					removed = removed + 1
				end)
				instances = nextInst
			end
		end

		local playerGui = context.Executor:FindFirstChild("PlayerGui")
		if playerGui then
			for _, gui in ipairs(playerGui:GetChildren()) do
				if gui:IsA("ScreenGui") and (gui.Name:lower():find("ad") or gui.Name:lower():find("sponsor")) then
					pcall(function()
					if gui.Enabled then
						gui.Enabled = false
						removed = removed + 1
					end
				end)
				end
			end
		end

		return removed > 0 and ("Removed %d ad instance(s)."):format(removed) or "No ads found."
	end;
}
