--!strict
local nositEnabled = false

return {
	Name = "nosit";
	Aliases = {};
	InverseAliases = {"unnosit"};
	Description = "Toggle disable seated state.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		local character = context.Executor.Character
		if not character then return "You don't have a character." end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoid then return "No humanoid found." end

		if context:isInvertedCall() then
			if not nositEnabled then return "Sitting already enabled." end
			nositEnabled = false
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			return "Seated state enabled."
		end

		nositEnabled = not nositEnabled
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, not nositEnabled)

		return nositEnabled and "Seated state disabled." or "Seated state enabled."
	end;
}
