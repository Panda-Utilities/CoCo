--!strict
return {
	Name = "clear",
	Aliases = {},
	Description = "Clear all lines above the entry line of the CoCo window.",
	Group = "DefaultUtil",
	Args = {},
	ClientRun = function()
		local gui = pcall(gethui) and gethui():FindFirstChild("CoCo")
		if not gui then
			return ""
		end
		local frame = gui:FindFirstChild("Frame")
		if frame then
			local templateLine = frame:FindFirstChild("Line")
			for _, child in pairs(frame:GetChildren()) do
				if child ~= templateLine and child.Name == "Line" and child:IsA("TextBox") then
					child:Destroy()
				end
			end
		end
		return ""
	end
}
