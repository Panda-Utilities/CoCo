--!strict
local Element = require("../../Components/init")
local Theme = require("../../Config")

type Cache = {
	box: Frame,
	boxStroke: UIStroke,
	boxOuterOutline: Frame,
	boxOuterStroke: UIStroke,
	boxInnerOutline: Frame,
	boxInnerStroke: UIStroke,
	boxFill: Frame,
	lastPosition: UDim2?,
	lastSize: UDim2?,
	lastOuterPosition: UDim2?,
	lastOuterSize: UDim2?,
	lastInnerPosition: UDim2?,
	lastInnerSize: UDim2?,
	lastFillPosition: UDim2?,
	lastFillSize: UDim2?,
	lastFillColor: Color3?,
	lastFillTransparency: number?,
	lastStrokeColor: Color3?,
	lastStrokeTransparency: number?,
}

local cacheMap: { any: Cache } = {}
local Box = {} :: {
	ensure: (any, Instance) -> (),
	update: (any, any, any) -> (),
	destroy: (any) -> (),
}

function Box.ensure(data: any, _screenGui: Instance)
	if cacheMap[data] then return end

	local boxFill = Element("Frame", {
		Parent = data.root,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.85,
		BorderSizePixel = 0,
		Visible = false,
	})

	local box = Element("Frame", {
		Parent = data.root,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = false,
	})

	local boxOuterOutline = Element("Frame", {
		Parent = data.root,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = false,
	})

	local boxOuterStroke = Element("UIStroke", {
		Parent = boxOuterOutline,
		Color = Theme.Colors.Stroke,
		Thickness = 1,
		LineJoinMode = Enum.LineJoinMode.Miter,
	})

	local boxInnerOutline = Element("Frame", {
		Parent = data.root,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Visible = false,
	})

	local boxInnerStroke = Element("UIStroke", {
		Parent = boxInnerOutline,
		Color = Theme.Colors.Stroke,
		Thickness = 1,
		LineJoinMode = Enum.LineJoinMode.Miter,
	})

	local boxStroke = Element("UIStroke", {
		Parent = box,
		Color = Color3.fromRGB(255, 255, 255),
		Thickness = 1,
		Transparency = 0,
		LineJoinMode = Enum.LineJoinMode.Miter,
	})

	data.box = box
	data.boxStroke = boxStroke
	data.boxOuterOutline = boxOuterOutline
	data.boxOuterStroke = boxOuterStroke
	data.boxInnerOutline = boxInnerOutline
	data.boxInnerStroke = boxInnerStroke
	data.boxFill = boxFill

	cacheMap[data] = {
		box = box,
		boxStroke = boxStroke,
		boxOuterOutline = boxOuterOutline,
		boxOuterStroke = boxOuterStroke,
		boxInnerOutline = boxInnerOutline,
		boxInnerStroke = boxInnerStroke,
		boxFill = boxFill,
	}
end

function Box.update(data: any, _entity: any, state: any)
	local cache = cacheMap[data]
	if not cache then return end

	if not state then
		cache.box.Visible = false
		cache.boxFill.Visible = false
		cache.boxOuterOutline.Visible = false
		cache.boxInnerOutline.Visible = false
		return
	end

	local features = data.features
	local hasBox = features["box"]
	local hasFill = features["box fill"]
	if not hasBox and not hasFill then
		cache.box.Visible = false
		cache.boxFill.Visible = false
		cache.boxOuterOutline.Visible = false
		cache.boxInnerOutline.Visible = false
		return
	end

	local size = state.size
	local boxPos = UDim2.fromOffset(0, 0)
	local boxSize = UDim2.fromOffset(size.X, size.Y)
	local outerPos = UDim2.fromOffset(-1, -1)
	local outerSize = UDim2.fromOffset(size.X + 2, size.Y + 2)
	local innerPos = UDim2.fromOffset(1, 1)
	local innerSize = UDim2.fromOffset(math.max(size.X - 2, 0), math.max(size.Y - 2, 0))

	if cache.lastPosition ~= boxPos then cache.lastPosition = boxPos; cache.box.Position = boxPos end
	if cache.lastSize ~= boxSize then cache.lastSize = boxSize; cache.box.Size = boxSize end
	if cache.lastOuterPosition ~= outerPos then cache.lastOuterPosition = outerPos; cache.boxOuterOutline.Position = outerPos end
	if cache.lastOuterSize ~= outerSize then cache.lastOuterSize = outerSize; cache.boxOuterOutline.Size = outerSize end
	if cache.lastInnerPosition ~= innerPos then cache.lastInnerPosition = innerPos; cache.boxInnerOutline.Position = innerPos end
	if cache.lastInnerSize ~= innerSize then cache.lastInnerSize = innerSize; cache.boxInnerOutline.Size = innerSize end
	if cache.lastFillPosition ~= boxPos then cache.lastFillPosition = boxPos; cache.boxFill.Position = boxPos end
	if cache.lastFillSize ~= boxSize then cache.lastFillSize = boxSize; cache.boxFill.Size = boxSize end

	local fillBgColor = state.boxFillColor
	local fillTrans = state.boxFillTransparency
	if cache.lastFillColor ~= fillBgColor then cache.lastFillColor = fillBgColor; cache.boxFill.BackgroundColor3 = fillBgColor end
	if cache.lastFillTransparency ~= fillTrans then cache.lastFillTransparency = fillTrans; cache.boxFill.BackgroundTransparency = fillTrans end

	local boxColor = state.boxColor
	local boxTransparency = state.boxTransparency
	if cache.lastStrokeColor ~= boxColor then cache.lastStrokeColor = boxColor; cache.boxStroke.Color = boxColor end
	if cache.lastStrokeTransparency ~= boxTransparency then
		cache.lastStrokeTransparency = boxTransparency
		cache.boxStroke.Transparency = boxTransparency
		cache.boxOuterStroke.Color = Theme.Colors.Stroke
		cache.boxOuterStroke.Transparency = boxTransparency
		cache.boxInnerStroke.Color = Theme.Colors.Stroke
		cache.boxInnerStroke.Transparency = boxTransparency
	end

	cache.box.Visible = hasBox
	cache.boxOuterOutline.Visible = hasBox
	cache.boxInnerOutline.Visible = hasBox
	cache.boxFill.Visible = hasFill
end

function Box.destroy(data: any)
	local cache = cacheMap[data]
	if cache then
		cache.box:Destroy()
		cache.boxFill:Destroy()
		cache.boxOuterOutline:Destroy()
		cache.boxInnerOutline:Destroy()
		cacheMap[data] = nil
	end
	data.box = nil
	data.boxFill = nil
	data.boxOuterOutline = nil
	data.boxInnerOutline = nil
	data.boxStroke = nil
	data.boxOuterStroke = nil
	data.boxInnerStroke = nil
end

return Box
