local savedPosition = nil

return {
	Name = "flashback";
	Aliases = {"diedtp"};
	Description = "Save position on death, run again to teleport back.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local root = humanoid.RootPart
		if not root then return "No root part." end

		if savedPosition then
			root.CFrame = savedPosition
			local pos = savedPosition
			savedPosition = nil
			return ("Teleported to (%.0f, %.0f, %.0f)."):format(pos.X, pos.Y, pos.Z)
		end

		savedPosition = root.CFrame

		humanoid.Died:Connect(function()
			savedPosition = nil
		end)

		return "Position saved. Run flashback again to return."
	end;
}
