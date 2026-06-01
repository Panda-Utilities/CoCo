--!strict
return {
	Name = "guiscale";
	Aliases = {};
	Description = "Set UI scale (0.5-2, default 1).";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "scale";
			Description = "Scale value";
			Default = 1;
		};
	};

	ClientRun = function(_, scale)
		scale = math.clamp(scale, 0.5, 2)

		local guiRoot = require("../../Config").GuiRoot
		if not guiRoot then return "No GUI root found." end

		local gui = guiRoot:FindFirstChild("CoCo")
		if not gui then return "CoCo GUI not found." end

		local uiScale = gui:FindFirstChildWhichIsA("UIScale")
		if not uiScale then
			uiScale = Instance.new("UIScale")
			uiScale.Name = "CoCoScale"
			uiScale.Parent = gui
		end

		uiScale.Scale = scale
		return ("UI scale set to %g."):format(scale)
	end;
}
