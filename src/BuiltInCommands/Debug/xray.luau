local xrayEnabled = false

local function setXray(state)
	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("BasePart")
			and not v.Parent:FindFirstChildWhichIsA("Humanoid")
			and not (v.Parent.Parent and v.Parent.Parent:FindFirstChildWhichIsA("Humanoid"))
		then
			v.LocalTransparencyModifier = state and 0.5 or 0
		end
	end
end

return {
	Name = "xray";
	Aliases = {};
	InverseAliases = {"unxray", "noxray"};
	Description = "Toggle x-ray (see through walls).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not xrayEnabled then return "X-ray already disabled." end
			xrayEnabled = false
			setXray(false)
			return "X-ray disabled."
		end

		xrayEnabled = not xrayEnabled
		setXray(xrayEnabled)

		return xrayEnabled and "X-ray enabled." or "X-ray disabled."
	end;
}
