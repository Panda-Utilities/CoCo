--!strict
return {
	Name = "walktopos",
	Aliases = { "walktoposition" },
	Description = "Walk your character to specific coordinates. Usage: walktopos <x> <y> <z>",
	Group = "DefaultDebug",
	Args = {
		{
			Type = "number",
			Name = "x",
			Description = "X coordinate",
		},
		{
			Type = "number",
			Name = "y",
			Description = "Y coordinate",
		},
		{
			Type = "number",
			Name = "z",
			Description = "Z coordinate",
		},
	},

	ClientRun = function(context, x, y, z)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		humanoid:MoveTo(Vector3.new(x, y, z))

		return ("Walking to (%g, %g, %g)."):format(x, y, z)
	end,
}
