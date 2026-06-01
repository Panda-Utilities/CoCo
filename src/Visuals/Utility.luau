--!strict

local R6_PARTS = { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" }
local R15_PARTS = { "Head", "UpperTorso", "LowerTorso", "LeftHand", "RightHand", "LeftFoot", "RightFoot", "LeftLowerArm", "RightLowerArm", "LeftLowerLeg", "RightLowerLeg", "LeftUpperArm", "RightUpperArm", "LeftUpperLeg", "RightUpperLeg" }

local function GetCharacter(player: Player): Model?
	return player and player.Character
end

local function GetBodyParts(character: Model): { BasePart }?
	if not character then return nil end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return nil end
	local parts: { BasePart } = {}
	local partNames = humanoid.RigType == Enum.HumanoidRigType.R6 and R6_PARTS or R15_PARTS
	for _, name in partNames do
		local part = character:FindFirstChild(name)
		if part and part:IsA("BasePart") then
			parts[#parts + 1] = part :: BasePart
		end
	end
	return #parts > 0 and parts or nil
end

return {
	GetCharacter = GetCharacter,
	GetBodyParts = GetBodyParts,
}
