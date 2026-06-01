--!strict
local Element = require("../../Components/init")
local Theme = require("../../Config")

type Cache = {
	healthOutline: Frame,
	healthOutlineStroke: UIStroke,
	healthBar: Frame,
	healthGradient: UIGradient,
	lastOutlinePosition: UDim2?,
	lastOutlineSize: UDim2?,
	lastOutlineTransparency: number?,
	lastBarPosition: UDim2?,
	lastBarSize: UDim2?,
	lastBarTransparency: number?,
	lastGradientColor: ColorSequence?,
}

local cacheMap: { any: Cache } = {}
local HealthBar = {} :: {
	ensure: (any, Instance) -> (),
	update: (any, any, any) -> (),
	destroy: (any) -> (),
}

function HealthBar.ensure(data: any, _screenGui: Instance)
	if cacheMap[data] then return end

	local healthOutline = Element("Frame", {
		Parent = data.root,
		BackgroundColor3 = Theme.Colors.Stroke,
		BorderSizePixel = 0,
		Visible = false,
	})

	local healthOutlineStroke = Element("UIStroke", {
		Parent = healthOutline,
		Color = Theme.Colors.Stroke,
		Enabled = false,
		Thickness = 1,
		LineJoinMode = Enum.LineJoinMode.Miter,
	})

	local healthBar = Element("Frame", {
		Parent = healthOutline,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
	})

	local healthGradient = Element("UIGradient", {
		Rotation = -90,
		Parent = healthBar,
	})

	data.healthOutline = healthOutline
	data.healthOutlineStroke = healthOutlineStroke
	data.healthBar = healthBar
	data.healthGradient = healthGradient

	cacheMap[data] = {
		healthOutline = healthOutline,
		healthOutlineStroke = healthOutlineStroke,
		healthBar = healthBar,
		healthGradient = healthGradient,
	}
end

function HealthBar.update(data: any, _entity: any, state: any)
	local cache = cacheMap[data]
	if not cache then return end

	if not state then
		cache.healthOutline.Visible = false
		return
	end

	if not data.features["health bar"] then
		cache.healthOutline.Visible = false
		return
	end

	local size = state.size
	local healthTransparency = state.healthTransparency
	local healthBarGap = state.healthBarGap
	local healthBarWidth = state.healthBarWidth
	local healthBarOutline = state.healthBarOutline
	local healthBarYOffset = state.healthBarYOffset
	local displayHealthRatio = state.displayHealthRatio

	local healthOutlineWidth = healthBarWidth + healthBarOutline * 2
	local healthOutlineHeight = math.max(size.Y - healthBarYOffset * 2, 0)

	local outlinePos = UDim2.fromOffset(-(healthBarGap + healthOutlineWidth), healthBarYOffset)
	local outlineSize = UDim2.fromOffset(healthOutlineWidth, healthOutlineHeight)
	if cache.lastOutlinePosition ~= outlinePos then cache.lastOutlinePosition = outlinePos; cache.healthOutline.Position = outlinePos end
	if cache.lastOutlineSize ~= outlineSize then cache.lastOutlineSize = outlineSize; cache.healthOutline.Size = outlineSize end
	if cache.lastOutlineTransparency ~= healthTransparency then
		cache.lastOutlineTransparency = healthTransparency
		cache.healthOutline.BackgroundTransparency = healthTransparency
	end

	local healthBarHeight = math.max(healthOutlineHeight - healthBarOutline * 2, 0)
	local barPos = UDim2.fromOffset(healthBarOutline, healthBarHeight * (1 - displayHealthRatio) + healthBarOutline)
	local barSize = UDim2.fromOffset(healthBarWidth, math.max(healthBarHeight * displayHealthRatio, 0))
	if cache.lastBarPosition ~= barPos then cache.lastBarPosition = barPos; cache.healthBar.Position = barPos end
	if cache.lastBarSize ~= barSize then cache.lastBarSize = barSize; cache.healthBar.Size = barSize end
	if cache.lastBarTransparency ~= healthTransparency then
		cache.lastBarTransparency = healthTransparency
		cache.healthBar.BackgroundTransparency = healthTransparency
	end

	local healthColor = state.healthColor
	local bottomColor = if state.healthBarGradientDirection == "brighter"
		then healthColor:Lerp(Color3.new(1, 1, 1), 0.8)
		else healthColor:Lerp(Color3.new(), 0.8)
	local gradColor = ColorSequence.new({
		ColorSequenceKeypoint.new(0, bottomColor),
		ColorSequenceKeypoint.new(1, healthColor),
	})
	if cache.lastGradientColor ~= gradColor then
		cache.lastGradientColor = gradColor
		cache.healthGradient.Color = gradColor
	end

	cache.healthOutline.Visible = true
end

function HealthBar.destroy(data: any)
	local cache = cacheMap[data]
	if cache then
		cache.healthOutline:Destroy()
		cache.healthBar:Destroy()
		cacheMap[data] = nil
	end
	data.healthOutline = nil
	data.healthBar = nil
	data.healthOutlineStroke = nil
	data.healthGradient = nil
end

return HealthBar
