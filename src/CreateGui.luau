--!strict
local Element = require("./Components/init")
local Config = require("./Config")

local function getParent()
	local success, gui = pcall(gethui)
	if success then
		return gui
	end
	return require("./Shared/Services").CoreGui
end

local function frame(props)
	props = props or {}
	return Element("ScrollingFrame", {
		BackgroundColor3 = props.BackgroundColor3 or Config.Colors.BackgroundDark,
		BackgroundTransparency = props.BackgroundTransparency or Config.Gui.BackgroundTransparency,
		BorderSizePixel = 0,
		CanvasSize = props.CanvasSize or UDim2.new(0, 0, 0, 0),
		Position = props.Position or UDim2.new(0.025, 0, 0, 25),
		ScrollBarThickness = props.ScrollBarThickness or Config.Gui.ScrollBarThickness,
		ScrollingDirection = props.ScrollingDirection or Enum.ScrollingDirection.Y,
		Selectable = false,
		Size = props.Size or UDim2.new(0.95, 0, 0, 0),
		Visible = props.Visible ~= nil and props.Visible or false,
		AutomaticCanvasSize = props.AutomaticCanvasSize or Enum.AutomaticSize.Y,
		Name = props.Name or "",
	}, props.Children)
end

local function padding(offsets)
	return Element("UIPadding", {
		PaddingBottom = UDim.new(0, offsets and offsets.bottom or 10),
		PaddingLeft = UDim.new(0, offsets and offsets.left or 10),
		PaddingRight = UDim.new(0, offsets and offsets.right or 10),
		PaddingTop = UDim.new(0, offsets and offsets.top or 10),
	})
end

local function listLayout(direction)
	return Element("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		FillDirection = direction or Enum.FillDirection.Vertical,
		Padding = direction == Enum.FillDirection.Horizontal and UDim.new(0, 7) or nil,
	})
end

local function textLabel(props)
	props = props or {}
	return Element("TextLabel", {
		BackgroundTransparency = 1,
		Font = props.Font or Enum.Font.Code,
		Text = props.Text or "",
		TextColor3 = props.TextColor3 or Config.Colors.TextPrimary,
		TextSize = props.TextSize or Config.Gui.DefaultTextSize,
		TextXAlignment = props.TextXAlignment or Enum.TextXAlignment.Left,
		TextYAlignment = props.TextYAlignment or Enum.TextYAlignment.Center,
		Size = props.Size or UDim2.new(1, 0, 0, 20),
		AutomaticSize = props.AutomaticSize or Enum.AutomaticSize.None,
		TextWrapped = props.TextWrapped or false,
		Name = props.Name or "TextLabel",
	}, props.Children)
end

local function textBox(props)
	props = props or {}
	return Element("TextBox", {
		BackgroundTransparency = 1,
		ClearTextOnFocus = false,
		Font = Enum.Font.Code,
		PlaceholderText = props.PlaceholderText or "",
		Position = props.Position or UDim2.new(0, 0, 0, 0),
		Size = props.Size or UDim2.new(1, 0, 0, 20),
		TextColor3 = props.TextColor3 or Config.Colors.TextPrimary,
		TextSize = Config.Gui.DefaultTextSize,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = props.TextYAlignment or Enum.TextYAlignment.Center,
		TextWrapped = props.TextWrapped or false,
		AutomaticSize = props.AutomaticSize or Enum.AutomaticSize.None,
		Selectable = false,
		Text = props.Text or "",
		Name = props.Name or "TextBox",
		LayoutOrder = props.LayoutOrder or 0,
	})
end

local function coloredFrame(props)
	props = props or {}
	local color = props.Color or Config.Colors.BackgroundMedium
	local transparency = props.Transparency or Config.Gui.AutocompleteBackgroundTransparency
	return Element("Frame", {
		BackgroundColor3 = color,
		BackgroundTransparency = transparency,
		BorderSizePixel = 0,
		LayoutOrder = props.LayoutOrder or 0,
		Name = props.Name or "",
		Size = props.Size or UDim2.new(1, 0, 0, 20),
	}, props.Children)
end

return function()
	local parent = getParent()
	Config.GuiRoot = parent

	local autocompleteButton = Element("TextButton", {
		BackgroundColor3 = Config.Colors.BackgroundMedium,
		BackgroundTransparency = Config.Gui.AutocompleteBackgroundTransparency,
		BorderSizePixel = 0,
		Font = Enum.Font.Code,
		Size = UDim2.new(1, 0, 0, 30),
		Text = "",
		TextColor3 = Config.Colors.TextPrimary,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, {
		textLabel({
			Name = "Typed",
			TextColor3 = Config.Colors.AutocompleteItem,
			Size = UDim2.new(1, 0, 1, 0),
		}),
		textLabel({
			Name = "Suggest",
			Size = UDim2.new(1, 0, 1, 0),
		}),
		padding({ left = 10, top = 0, bottom = 0, right = 0 }),
	})

	local root = Element("ScreenGui", {
		Name = "CoCo",
		DisplayOrder = 1000,
		ResetOnSpawn = false,
		AutoLocalize = false,
		Parent = parent,
	}, {
		frame({
			Name = "Frame",
			Children = {
				listLayout(),
				textBox({
					Name = "Line",
					Text = "made with ♡",
					AutomaticSize = Enum.AutomaticSize.Y,
					TextWrapped = true,
					TextYAlignment = Enum.TextYAlignment.Top,
				}),
				padding(),
				Element("Frame", {
					BackgroundTransparency = 1,
					LayoutOrder = Config.Gui.EntryLayoutOrder,
					Name = "Entry",
					Size = UDim2.new(1, 0, 0, 20),
				}, {
					listLayout(Enum.FillDirection.Horizontal),
					textBox({
						LayoutOrder = Config.Gui.EntryLayoutOrder,
						PlaceholderText = "enter a command here",
						Position = UDim2.new(0, 140, 0, 0),
					}),
					textLabel({
						Text = "",
						TextColor3 = Config.Colors.TextAccent,
						AutomaticSize = Enum.AutomaticSize.X,
						Size = UDim2.new(0, 0, 0, 20),
					}),
				}),
			},
		}),

		frame({
			Name = "Autocomplete",
			BackgroundColor3 = Config.Colors.BackgroundMedium,
			BackgroundTransparency = Config.Gui.AutocompleteBackgroundTransparency,
			Position = UDim2.new(0, 167, 0, 75),
			Size = UDim2.new(0, 200, 0, 200),
			Children = {
				listLayout(),
				coloredFrame({
					Color = Config.Colors.BackgroundMedium,
					Transparency = Config.Gui.SectionBackgroundTransparency,
					LayoutOrder = -2,
					Name = "Title",
					Size = UDim2.new(1, 0, 0, 40),
					Children = {
						textLabel({
							Name = "Field",
							Text = "from",
							Font = Enum.Font.SourceSansBold,
							TextSize = 20,
							Size = UDim2.new(0, 37, 1, 0),
							Children = {
								textLabel({
									Name = "Type",
									Font = Enum.Font.SourceSans,
									TextSize = 15,
									Size = UDim2.new(0, 0, 1, 0),
									Position = UDim2.new(1, 0, 0, 0),
								}),
							},
						}),
						padding({ left = 10, top = 0, bottom = 0, right = 0 }),
					},
				}),

				coloredFrame({
					Color = Config.Colors.BackgroundMedium,
					Transparency = Config.Gui.SectionBackgroundTransparency,
					LayoutOrder = -1,
					Name = "Description",
					Size = UDim2.new(1, 0, 0, 20),
					Children = {
						textLabel({
							Name = "Label",
							Text = "The players to teleport. The players to teleport. The players to teleport. The players to teleport. ",
							Font = Enum.Font.SourceSansLight,
							TextSize = 16,
							TextWrapped = true,
							Size = UDim2.new(1, 0, 1, 0),
							TextYAlignment = Enum.TextYAlignment.Top,
						}),
						padding({ left = 10, top = 10, bottom = 10, right = 10 }),
					},
				}),

			autocompleteButton,
		},
		}),
	})

	return root
end
