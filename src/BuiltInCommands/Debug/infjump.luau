local Services = require("../../Shared/Services")
local UserInputService = Services.UserInputService

local infJumpConnection = nil
local infJumpDebounce = false

return {
	Name = "infjump";
	Aliases = {"infinitejump"};
	InverseAliases = {"uninfjump", "noinfjump"};
	Description = "Toggle infinite jump.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not infJumpConnection then return "Infinite jump already disabled." end
			infJumpConnection:Disconnect()
			infJumpConnection = nil
			infJumpDebounce = false
			return "Infinite jump disabled."
		end

		if infJumpConnection then
			infJumpConnection:Disconnect()
			infJumpConnection = nil
			infJumpDebounce = false
			return "Infinite jump disabled."
		end

		infJumpConnection = UserInputService.JumpRequest:Connect(function()
			if infJumpDebounce then return end
			infJumpDebounce = true

			local character = context.Executor.Character
			if character then
				local humanoid = character:FindFirstChildWhichIsA("Humanoid")
				if humanoid then
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end

			task.wait()
			infJumpDebounce = false
		end)

		return "Infinite jump enabled."
	end;
}
