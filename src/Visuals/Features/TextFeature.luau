--!strict
local Element = require("../../Components/init")
local Fonts = require("../Fonts")
local Theme = require("../../Config")

export type TextFeatureConfig = {
	storageKey: string,
	strokeKey: string,
	featureKey: string,
	positionFn: (Vector2, Vector2, any) -> UDim2,
	textFn: (any) -> string,
	colorKey: string,
	transparencyKey: string,
	anchorPoint: Vector2?,
	textSize: number?,
	labelSize: UDim2?,
	visibleFn: ((string, any) -> boolean)?,
}

export type Module = {
	ensure: (any, Instance) -> (),
	update: (any, any, any) -> (),
	destroy: (any) -> (),
}

local function TextFeature(config: TextFeatureConfig): Module
	local cacheMap: { any: { label: TextLabel, stroke: UIStroke, lastText: string?, lastPosition: UDim2?, lastColor: Color3?, lastTransparency: number? } } = {}

	local module: Module = {}

	function module.ensure(data: any, screenGui: Instance)
		if cacheMap[data] then return end

		local label = Element("TextLabel", {
			Parent = screenGui,
			AnchorPoint = config.anchorPoint or Vector2.new(0.5, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Font = Enum.Font.Code,
			Size = config.labelSize or UDim2.fromOffset(160, 14),
			TextSize = config.textSize or 12,
			TextTransparency = 0,
			TextStrokeTransparency = 1,
			Visible = false,
		})
		Fonts.Apply(label)

		local stroke = Element("UIStroke", {
			Parent = label,
			Color = Theme.Colors.Stroke,
			Transparency = 0,
			Thickness = 1,
			LineJoinMode = Enum.LineJoinMode.Miter,
		})

		data[config.storageKey] = label
		data[config.strokeKey] = stroke

		cacheMap[data] = { label = label, stroke = stroke }
	end

	function module.update(data: any, _entity: any, state: any)
		local cache = cacheMap[data]
		if not cache then return end

		if not state then
			cache.label.Visible = false
			return
		end

		if not data.features[config.featureKey] then
			cache.label.Visible = false
			return
		end

		local pos = config.positionFn(state.min, state.size, state)
		if cache.lastPosition ~= pos then
			cache.lastPosition = pos
			cache.label.Position = pos
		end

		Fonts.Apply(cache.label)

		local text = config.textFn(state)
		if cache.lastText ~= text then
			cache.lastText = text
			cache.label.Text = text
		end

		local color: Color3 = state[config.colorKey]
		if cache.lastColor ~= color then
			cache.lastColor = color
			cache.label.TextColor3 = color
		end

		local transparency: number = state[config.transparencyKey]
		if cache.lastTransparency ~= transparency then
			cache.lastTransparency = transparency
			cache.label.TextTransparency = transparency
			cache.stroke.Transparency = transparency
		end

		if config.visibleFn then
			cache.label.Visible = config.visibleFn(text, state)
		else
			cache.label.Visible = true
		end
	end

	function module.destroy(data: any)
		local cache = cacheMap[data]
		if cache then
			cache.label:Destroy()
			cacheMap[data] = nil
		end
		data[config.storageKey] = nil
		data[config.strokeKey] = nil
	end

	return module
end

return TextFeature
