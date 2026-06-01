--!strict
local Element = require("../../Components/init")

local Highlight = {} :: {
	ensure: (any, Instance) -> (),
	update: (any, any, any) -> (),
	destroy: (any) -> (),
}

function Highlight.ensure(data: any, _screenGui: Instance)
	if data.highlight then return end

	local parent = (pcall(gethui) and gethui()) or game:GetService("CoreGui")
	data.highlight = Element("Highlight", {
		Parent = parent,
	}) :: Highlight
end

function Highlight.update(data: any, _entity: any, state: any)
	if not state then
		if data.highlight then
			data.highlight.Enabled = false
		end
		return
	end
	local features = data.features
	if not features["highlight"] then
		if data.highlight then
			data.highlight.Enabled = false
		end
		return
	end

	if not data.highlight then return end

	local character = state.character
	if not character then
		data.highlight.Enabled = false
		return
	end

	data.highlight.Adornee = character
	data.highlight.DepthMode = state.highlightBehindWalls
		and Enum.HighlightDepthMode.AlwaysOnTop
		or Enum.HighlightDepthMode.Occluded
	data.highlight.FillColor = state.highlightFillColor
	data.highlight.FillTransparency = state.highlightFillTransparency
	data.highlight.OutlineColor = state.highlightOutlineColor
	data.highlight.OutlineTransparency = state.highlightOutlineTransparency
	data.highlight.Enabled = true
end

function Highlight.destroy(data: any)
	if data.highlight then
		data.highlight:Destroy()
		data.highlight = nil
	end
end

return Highlight
