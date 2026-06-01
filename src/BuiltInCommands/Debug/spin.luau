return {
	Name = "spin";
	Aliases = {};
	InverseAliases = {"unspin"};
	Description = "Toggle spin your character (optional: speed).";
	Group = "DefaultDebug";
	Args = {
		{
			Type = "number";
			Name = "speed";
			Description = "Spin speed (default: 20)";
			Default = 20;
			Optional = true;
		};
	};

	ClientRun = function(context, speed)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		local rootPart = humanoid.RootPart
		if not rootPart then return "No root part found." end

		local existing = nil
		for _, v in ipairs(rootPart:GetChildren()) do
			if v.Name == "Spinning" then
				existing = v
				break
			end
		end

		if context:isInvertedCall() then
			if not existing then return "Spin already disabled." end
			existing:Destroy()
			return "Spin disabled."
		end

		if existing then
			existing:Destroy()
			return "Spin disabled."
		end

		local spin = Instance.new("BodyAngularVelocity")
		spin.Name = "Spinning"
		spin.Parent = rootPart
		spin.MaxTorque = Vector3.new(0, math.huge, 0)
		spin.AngularVelocity = Vector3.new(0, speed, 0)

		return ("Spin enabled (speed: %d)."):format(speed)
	end;
}
