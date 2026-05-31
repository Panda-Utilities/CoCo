--!strict
return {
	Name = "anchor";
	Aliases = {"anc"};
	Description = "Toggle anchor on your root part.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "No character." end

		local root = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
		if not root then return "No root part found." end

		root.Anchored = not root.Anchored
		return root.Anchored and "Anchored." or "Unanchored."
	end;
}
