--!strict
return {
	Name = "clearchar";
	Aliases = {"clearcharappearance"};
	Description = "Clear all character accessories and clothing.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local removed = 0
		for _, v in ipairs(character:GetChildren()) do
			if v:IsA("Accessory") or v:IsA("Hat") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
				v:Destroy()
				removed = removed + 1
			end
		end

		local head = character:FindFirstChild("Head")
		if head then
			for _, v in ipairs(head:GetChildren()) do
				if v:IsA("SpecialMesh") or v:IsA("Decal") then
					if v.Name ~= "face" then
						v:Destroy()
						removed = removed + 1
					end
				end
			end
		end

		return ("Cleared %d item(s)."):format(removed)
	end;
}
