return {
	Name = "btools";
	Aliases = {};
	Description = "Give HopperBin building tools (move, resize, copy, color).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local backpack = context.Executor:FindFirstChildWhichIsA("Backpack")
		if not backpack then return "No backpack found." end

		for binType = 1, 4 do
			local tool = Instance.new("HopperBin")
			tool.BinType = binType
			tool.Parent = backpack
		end

		return "Building tools added to backpack."
	end;
}
