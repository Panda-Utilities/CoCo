--!strict
	return function(CoCo, gui)
	local String = require("../../Shared/String")
	local Janitor = require("../../../packages/janitor")
	local Services = require("../../Shared/Services")
	local TweenService = Services.TweenService

	local AutoComplete = {
		Items = {},
		ItemOptions = {},
		SelectedItem = 0,
		Janitor = Janitor.new(),
	}



	local Gui = gui:WaitForChild("Autocomplete")
	local AutoItem = Gui:WaitForChild("TextButton")
	local Title = Gui:WaitForChild("Title")
	local Description = Gui:WaitForChild("Description")
	local Entry = gui:WaitForChild("Frame"):WaitForChild("Entry")
	AutoItem.Parent = nil

	local defaultBarThickness = Gui.ScrollBarThickness
	local acTweenInfo = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local function SetText(obj, textObj, text, sizeFromContents)
		obj.Visible = text ~= nil
		textObj.Text = text or ""

		if sizeFromContents then
			textObj.Size = UDim2.new(
				0,
				textObj.TextBounds.X,
				obj.Size.Y.Scale,
				obj.Size.Y.Offset
			)
		end
	end

	local GUI_PADDING = 10

	local function updateContainerSize()
		Gui.Size = UDim2.new(
			0,
			math.max(Title.Field.TextBounds.X + Title.Field.Type.TextBounds.X + GUI_PADDING, Gui.Size.X.Offset),
			0,
			math.min(Gui.UIListLayout.AbsoluteContentSize.Y, Gui.Parent.AbsoluteSize.Y - Gui.AbsolutePosition.Y - GUI_PADDING)
		)
	end

	local function updateInfoDisplay(options)
		SetText(Title, Title.Field, options.name, true)
		SetText(
			Title.Field.Type,
			Title.Field.Type,
			options.type and ": " .. options.type:sub(1, 1):upper() .. options.type:sub(2),
			true
		)

		Title.Field.Type.Position = UDim2.new(0, Title.Field.Size.X.Offset, 0, 0)
		SetText(Description, Description.Label, options.description)

		Description.Label.TextColor3 = options.invalid and Color3.fromRGB(255, 73, 73) or Color3.fromRGB(255, 255, 255)
		Description.Size = UDim2.new(1, 0, 0, 40)

		while not Description.Label.TextFits do
			Description.Size = Description.Size + UDim2.new(0, 0, 0, 2)

			if Description.Size.Y.Offset > 500 then
				break
			end
		end

		Gui.UIListLayout:ApplyLayout()
		updateContainerSize()
		Gui.ScrollBarThickness = defaultBarThickness
	end

	function AutoComplete:show(items, options)
		options = options or {}

		for _, item in ipairs(self.Items) do
			if item.gui then
				item.gui:Destroy()
			end
		end

		self.SelectedItem = 1
		self.Items = items
		self.Prefix = options.prefix or ""
		self.LastItem = options.isLast or false
		self.Command = options.command
		self.Arg = options.arg
		self.NumArgs = options.numArgs
		self.IsPartial = options.isPartial

		local autocompleteWidth = 200

		Gui.ScrollBarThickness = 0

		for i, item in ipairs(self.Items) do
			local leftText = item[1]
			local displayText = item[3] or item[2]
			local rightText = displayText

			local btn = AutoItem:Clone()
			btn.Name = leftText .. tostring(rightText)
			btn.BackgroundTransparency = i == self.SelectedItem and 0.5 or 1

			local start, stop = string.find(rightText:lower(), leftText:lower(), 1, true)
			if not start then start, stop = 1, 0 end
			btn.Typed.Text = string.rep(" ", start - 1) .. leftText
			btn.Suggest.Text = string.sub(rightText, 0, start - 1)
				.. string.rep(" ", #leftText)
				.. string.sub(rightText, stop + 1)

			btn.Parent = Gui
			btn.LayoutOrder = i

			local maxBounds = math.max(btn.Typed.TextBounds.X, btn.Suggest.TextBounds.X) + 20
			if maxBounds > autocompleteWidth then
				autocompleteWidth = maxBounds
			end

			item.gui = btn
		end

		Gui.UIListLayout:ApplyLayout()

		for _, item in ipairs(self.Items) do
			if item.gui then
				local targetTransparency = item.gui.BackgroundTransparency
				item.gui.BackgroundTransparency = 1
				TweenService:Create(item.gui, acTweenInfo, { BackgroundTransparency = targetTransparency }):Play()
			end
		end

		TweenService:Create(Gui, acTweenInfo, { BackgroundTransparency = 0.5 }):Play()

		for _, desc in ipairs(Gui:GetDescendants()) do
			if desc:IsA("TextLabel") or desc:IsA("TextBox") then
				desc.TextTransparency = 1
				TweenService:Create(desc, acTweenInfo, { TextTransparency = 0 }):Play()
			end
		end

		local text = Entry.TextBox.Text
		local words = String.splitString(text)
		if text:sub(#text, #text) == " " and not options.at then
			words[#words + 1] = "e"
		end
		table.remove(words, #words)
		local extra = (options.at and options.at or (#table.concat(words, " ") + 1)) * 7

		Gui.Position =
			UDim2.new(0, Entry.TextBox.AbsolutePosition.X - 10 + extra, 0, Entry.TextBox.AbsolutePosition.Y + 30)
		Gui.Size = UDim2.new(0, autocompleteWidth, 0, Gui.UIListLayout.AbsoluteContentSize.Y)
		Gui.Visible = true

		updateInfoDisplay(self.Items[1] and self.Items[1].options or options)
	end

	function AutoComplete:getSelectedItem()
		if Gui.Visible == false then
			return nil
		end
		return AutoComplete.Items[AutoComplete.SelectedItem]
	end

	function AutoComplete:hide()
		local hideTween = TweenService:Create(Gui, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 1 })
		hideTween.Completed:Connect(function()
			Gui.Visible = false
		end)
		hideTween:Play()

		for _, item in ipairs(self.Items) do
			if item.gui then
				TweenService:Create(item.gui, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()
			end
		end

		for _, desc in ipairs(Gui:GetDescendants()) do
			if desc:IsA("TextLabel") or desc:IsA("TextBox") then
				TweenService:Create(desc, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { TextTransparency = 1 }):Play()
			end
		end
	end

	function AutoComplete:isVisible()
		return Gui.Visible
	end

	function AutoComplete:select(delta)
		if not Gui.Visible then return end

		self.SelectedItem = self.SelectedItem + delta

		if self.SelectedItem > #self.Items then
			self.SelectedItem = 1
		elseif self.SelectedItem < 1 then
			self.SelectedItem = #self.Items
		end

		for i, item in ipairs(self.Items) do
			item.gui.BackgroundTransparency = i == self.SelectedItem and 0.5 or 1
		end

		Gui.CanvasPosition = Vector2.new(
			0,
			math.max(
				0,
				Title.Size.Y.Offset
					+ Description.Size.Y.Offset
					+ self.SelectedItem * AutoItem.Size.Y.Offset
					- Gui.Size.Y.Offset
			)
		)

		if self.Items[self.SelectedItem] and self.Items[self.SelectedItem].options then
			updateInfoDisplay(self.Items[self.SelectedItem].options or {})
		end
	end

	AutoComplete.Janitor:Add(
		Gui.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateContainerSize),
		"Disconnect"
	)

	function AutoComplete:destroy()
		self.Janitor:Destroy()
	end

	return AutoComplete
end