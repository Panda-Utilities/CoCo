--!strict
return {
	Name = "headsize";
	Aliases = {};
	Description = "Set your head size (1-10).";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "size";
			Description = "Head size (default: 1)";
			Default = 1;
		};
	};

	ClientRun = function(context, size)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local head = character:FindFirstChild("Head")
		if not head then return "No head found." end

		size = math.clamp(size, 0.1, 10)
		head.Size = Vector3.new(size, size, size)
		return ("Head size set to %g."):format(size)
	end;
}
