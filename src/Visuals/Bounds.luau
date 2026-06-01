--!strict

local Bounds = {}

local function rootPartBounds(camera: Camera, rootPart: BasePart?, character: Model?): (Vector2?, Vector2?, boolean)
	if not rootPart then return nil, nil, false end
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return nil, nil, false end
	local isR6 = humanoid.RigType == Enum.HumanoidRigType.R6
	local topOffset = isR6 and 2.8 or 3.0
	local bottomOffset = isR6 and 3.0 or 3.5
	local topPos = rootPart.Position + Vector3.new(0, topOffset, 0)
	local bottomPos = rootPart.Position - Vector3.new(0, bottomOffset, 0)
	local top2D = camera:WorldToViewportPoint(topPos)
	local bottom2D = camera:WorldToViewportPoint(bottomPos)
	if top2D.Z <= 0 and bottom2D.Z <= 0 then return nil, nil, false end
	local height = math.abs(top2D.Y - bottom2D.Y)
	local sp = camera:WorldToViewportPoint(rootPart.Position)
	local center = Vector2.new(sp.X, (top2D.Y + bottom2D.Y) / 2)
	local size = Vector2.new(height * 0.65, height)
	local mn = center - size / 2
	local mx = center + size / 2
	local padding = Vector2.new(2, 2)
	return mn - padding, mx + padding, true
end

local CORNER_OFFSETS = {
	Vector3.new(-1, -1, -1), Vector3.new(-1, -1, 1), Vector3.new(-1, 1, -1), Vector3.new(-1, 1, 1),
	Vector3.new(1, -1, -1),  Vector3.new(1, -1, 1),  Vector3.new(1, 1, -1),  Vector3.new(1, 1, 1),
}

function Bounds.Get(esp: any, camera: Camera, parts: { BasePart }?, rootPart: BasePart?, character: Model?): (Vector2?, Vector2?, boolean)
	if esp.DynamicBoxes and parts and #parts > 0 then
		local screenMin = Vector2.new(math.huge, math.huge)
		local screenMax = Vector2.new(-math.huge, -math.huge)
		local onScreen = false

		for _, part in parts do
			if part.Parent and part.Parent:IsA("Tool") then continue end
			if rootPart and (part.Position - rootPart.Position).Magnitude > 15 then continue end

			local cf = part.CFrame
			local hs = part.Size * 0.5

			for _, offset in CORNER_OFFSETS do
				local p = cf * (hs * offset)
				local screen = camera:WorldToViewportPoint(p)
				if screen.Z > 0 then
					onScreen = true
					if screen.X < screenMin.X then screenMin = Vector2.new(screen.X, screenMin.Y) end
					if screen.Y < screenMin.Y then screenMin = Vector2.new(screenMin.X, screen.Y) end
					if screen.X > screenMax.X then screenMax = Vector2.new(screen.X, screenMax.Y) end
					if screen.Y > screenMax.Y then screenMax = Vector2.new(screenMax.X, screen.Y) end
				end
			end
		end

		if not onScreen then return nil, nil, false end

		local padding = Vector2.new(2, 2)
		return screenMin - padding, screenMax + padding, true
	end

	return rootPartBounds(camera, rootPart, character)
end

return Bounds
