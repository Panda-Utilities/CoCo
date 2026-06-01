return {
	Name = "light";
	Aliases = {};
	Description = "Attach a light to your character.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local head = character:FindFirstChild("Head")
		if not head then return "No head found." end

		local existing = head:FindFirstChild("CharLight")
		if existing then
			existing:Destroy()
			return "Light removed."
		end

		local light = Instance.new("PointLight")
		light.Name = "CharLight"
		light.Brightness = 3
		light.Range = 15
		light.Color = Color3.new(1, 1, 1)
		light.Parent = head

		return "Light attached."
	end;
}
