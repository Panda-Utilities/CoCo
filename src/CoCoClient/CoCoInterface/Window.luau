--!strict
local Services = require("../../Shared/Services")
local GuiService = Services.GuiService
local UserInputService = Services.UserInputService
local RunService = Services.RunService
local Lighting = Services.Lighting
local Janitor = require("../../../packages/janitor")
local Ripple = require("../../../packages/ripple")
local String = require("../../Shared/String")
local MobileSupport = require("./MobileSupport")

local WINDOW_MAX_HEIGHT = 300
local MOUSE_TOUCH_ENUM = { Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.Touch }

local Window = {
	Valid = true,
	AutoComplete = nil,
	ProcessEntry = nil,
	OnTextChanged = nil,
	CoCo = nil,
	GuiRoot = nil,
	HistoryState = nil,
	Janitor = Janitor.new(),
	LastLineText = nil,
	LastLineGui = nil,
	DuplicateCount = 0,
}

local ANIM_SLIDE_DISTANCE = -80
local BASE_Y_OFFSET = 25

local slideSpring = Ripple.createSpring(ANIM_SLIDE_DISTANCE, {
	frequency = 4,
	dampingRatio = 0.75,
})

local fadeSpring = Ripple.createSpring(1, {
	frequency = 4,
	dampingRatio = 0.8,
})

local heightSpring = Ripple.createSpring(0, {
	frequency = 5,
	dampingRatio = 0.8,
})

local FOV_ZOOMED = 55
local BLUR_SIZE = 12

local fovSpring = Ripple.createSpring(70, {
	frequency = 4,
	dampingRatio = 0.8,
})

local blurSpring = Ripple.createSpring(0, {
	frequency = 4,
	dampingRatio = 0.8,
})

local defaultFov = 70

local blurEffect = Instance.new("BlurEffect")
blurEffect.Size = 0
blurEffect.Parent = Lighting

local contentHeight = 0
local isHiding = false
local mobileToggle = nil
local justShown = false

local function getGui()
	local root = Window.GuiRoot
	if not root then return nil end
	local gui = root:WaitForChild("CoCo"):WaitForChild("Frame")
	return gui
end

function Window:getGui()
	return getGui()
end

local function getLine()
	local g = getGui()
	return g and g:FindFirstChild("Line")
end

local function getEntry()
	local g = getGui()
	return g and g:FindFirstChild("Entry")
end

function Window:updateLabel()
	local entry = getEntry()
	if entry then
		entry.TextLabel.Text = "CoCo$"
	end
end

function Window:getLabel()
	local entry = getEntry()
	return entry and entry.TextLabel.Text or "CoCo$"
end

function Window:updateWindowHeight()
	local gui = getGui()
	if not gui then return end
	contentHeight = gui.UIListLayout.AbsoluteContentSize.Y
		+ gui.UIPadding.PaddingTop.Offset
		+ gui.UIPadding.PaddingBottom.Offset
	local clamped = math.clamp(contentHeight, 0, WINDOW_MAX_HEIGHT)
	if math.abs(heightSpring:getPosition() - clamped) > 0.5 then
		heightSpring:setGoal(clamped)
	end
end

function Window:addLine(text, options)
	options = options or {}
	text = tostring(text)

	if typeof(options) == "Color3" then
		options = { Color = options }
	end

	if #text == 0 then
		Window:updateWindowHeight()
		return
	end

	if text == Window.LastLineText then
		Window.DuplicateCount += 1
		if Window.LastLineGui then
			Window.LastLineGui.Text = text .. " x" .. (Window.DuplicateCount + 1)
		end
		Window:updateWindowHeight()
		return
	end

	Window.LastLineText = text
	Window.DuplicateCount = 0

	local gui = getGui()
	if not gui then return end
	local line = getLine()
	if not line then return end

	local str = String.emulateTabstops(text, 8)
	local newLine = line:Clone()
	newLine.Text = str
	newLine.TextColor3 = options.Color or newLine.TextColor3
	newLine.RichText = options.RichText or false
	newLine.Parent = gui
	Window.LastLineGui = newLine
end

function Window:isVisible()
	local gui = getGui()
	if not gui then return false end
	if isHiding then return false end
	return gui.Visible
end

function Window:setVisible(visible)
	local gui = getGui()
	if not gui then return end

	if visible then
		isHiding = false
		slideSpring:setPosition(ANIM_SLIDE_DISTANCE)
		fadeSpring:setPosition(1)
		gui.Position = UDim2.new(MobileSupport.IsTouchDevice and 0 or 0.025, 0, 0, BASE_Y_OFFSET + ANIM_SLIDE_DISTANCE)
		gui.BackgroundTransparency = 1
		gui.Visible = true
		slideSpring:setGoal(0)
		fadeSpring:setGoal(0.4)

		justShown = true
		task.delay(0.3, function()
			justShown = false
		end)

		local camera = workspace.CurrentCamera
		if camera then
			defaultFov = camera.FieldOfView
			fovSpring:setPosition(defaultFov)
			blurSpring:setPosition(0)
			fovSpring:setGoal(FOV_ZOOMED)
			blurSpring:setGoal(BLUR_SIZE)
		end
	else
		isHiding = true
		slideSpring:setGoal(ANIM_SLIDE_DISTANCE)
		fadeSpring:setGoal(1)
		fovSpring:setGoal(defaultFov)
		blurSpring:setGoal(0)
	end

	local entry = getEntry()
	if visible and entry then
		entry.TextBox:CaptureFocus()
		self:setEntryText("")

		if self.CoCo.ActivationUnlocksMouse then
			self.PreviousMouseBehavior = UserInputService.MouseBehavior
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		end
	elseif entry then
		entry.TextBox.Text = ""
		entry.TextBox:ReleaseFocus()
		self.AutoComplete:hide()

		if self.PreviousMouseBehavior then
			UserInputService.MouseBehavior = self.PreviousMouseBehavior
			self.PreviousMouseBehavior = nil
		end
	end

	if mobileToggle then
		mobileToggle.Visible = MobileSupport.IsTouchDevice and not visible
	end
end

function Window:hide()
	return self:setVisible(false)
end

function Window:show()
	return self:setVisible(true)
end

function Window:setEntryText(text)
	local entry = getEntry()
	if not entry then return end
	entry.TextBox.Text = text

	if self:isVisible() then
		entry.TextBox:CaptureFocus()
		if #text > 0 then
			entry.TextBox.CursorPosition = #text + 1
		end
		Window:updateWindowHeight()
	end

	if #text == 0 then
		local guard
		guard = entry.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
			guard:Disconnect()
			if entry.TextBox.Text ~= "" then
				entry.TextBox.Text = ""
			end
		end)
		task.defer(function()
			if guard then
				guard:Disconnect()
			end
		end)
	end
end

function Window:getEntryText()
	local entry = getEntry()
	if not entry then return "" end
	return entry.TextBox.Text:gsub("\t", "")
end

function Window:setIsValidInput(isValid, errorText)
	local entry = getEntry()
	if not entry then return end
	entry.TextBox.TextColor3 = isValid and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 73, 73)
	self.Valid = isValid
	self._errorText = errorText
end

function Window:hideInvalidState()
	local entry = getEntry()
	if entry then
		entry.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	end
end

function Window:loseFocus(submit)
	local text = self:getEntryText()

	if submit then
		local item = self.AutoComplete and self.AutoComplete:getSelectedItem()
		if item then
			local cmd = self.CoCo.Dispatcher:evaluate(text, nil, true)
			local alreadyComplete = cmd and cmd:getLastArgument() and cmd:getLastArgument().RawValue == item[2]
			if not alreadyComplete then
				local lastSpace = text:match("^(.*)[%s]")
				if lastSpace then
					if lastSpace ~= item[2] then
						text = lastSpace .. " " .. item[2]
					end
				else
					text = item[2]
				end
				self:setEntryText(text)
				text = self:getEntryText()
			end
		end

		if self.Valid then
			task.wait()
			self:setEntryText("")
			self.ProcessEntry(text)
		else
			self:addLine(self._errorText, Color3.fromRGB(255, 153, 153))
			task.wait()
			self:setEntryText("")
		end

		for _ = 1, 5 do
			task.defer(function()
				local e = getEntry()
				if e and e.TextBox.Text:match("^%s") then
					e.TextBox.Text = e.TextBox.Text:gsub("^%s+", "")
				end
			end)
		end

		local gui = getGui()
		if gui then
			gui.CanvasPosition = Vector2.new(0, gui.AbsoluteCanvasSize.Y)
		end

		return
	end

	self:clearHistoryState()

	local gui = getGui()
	if gui and self:isVisible() and not GuiService.MenuIsOpen then
		local entry = getEntry()
		if entry then
			entry.TextBox:CaptureFocus()
		end
	elseif GuiService.MenuIsOpen and gui and gui.Visible then
		self:hide()
	end
end

function Window:traverseHistory(delta)
	local history = self.CoCo.Dispatcher:getHistory()

	if self.HistoryState == nil then
		self.HistoryState = {
			Position = #history + 1,
			InitialText = self:getEntryText(),
		}
	end

	self.HistoryState.Position = math.clamp(self.HistoryState.Position + delta, 1, #history + 1)

	self:setEntryText(
		self.HistoryState.Position == #history + 1 and self.HistoryState.InitialText
		or history[self.HistoryState.Position]
	)
end

function Window:clearHistoryState()
	self.HistoryState = nil
end

function Window:selectVertical(delta)
	if self.AutoComplete:isVisible() and not self.HistoryState then
		self.AutoComplete:select(delta)
	else
		self:traverseHistory(delta)
	end
end

local lastPressTime = 0
local pressCount = 0

function Window:beginInput(input, gameProcessed)
	if GuiService.MenuIsOpen then
		self:hide()
	end

	if gameProcessed and self:isVisible() == false then
		return
	end

	if self.CoCo.ActivationKeys[input.KeyCode] then
		if self.CoCo.MashToEnable and not self.CoCo.Enabled then
			if os.clock() - lastPressTime < 1 then
				if pressCount >= 5 then
					return self.CoCo:setEnabled(true)
				else
					pressCount += 1
				end
			else
				pressCount = 1
			end
			lastPressTime = os.clock()
		elseif self.CoCo.Enabled then
			self:setVisible(not self:isVisible())
			task.wait()
			self:setEntryText("")

			if GuiService.MenuIsOpen then
				self:hide()
			end
		end

		return
	end

	if self.CoCo.Enabled == false or not self:isVisible() then
		if self:isVisible() then
			self:hide()
		end
		return
	end

	if justShown then
		return
	end

	if self.CoCo.HideOnLostFocus and table.find(MOUSE_TOUCH_ENUM, input.UserInputType) then
		local gui = getGui()
		if not gui then return end
		local ps = input.Position
		local ap = gui.AbsolutePosition
		local as = gui.AbsoluteSize
		if ps.X < ap.X or ps.X > ap.X + as.X or ps.Y < ap.Y or ps.Y > ap.Y + as.Y then
			self:hide()
		end
	elseif input.KeyCode == Enum.KeyCode.Down then
		self:selectVertical(1)
	elseif input.KeyCode == Enum.KeyCode.Up then
		self:selectVertical(-1)
	elseif input.KeyCode == Enum.KeyCode.Return then
		if self.AutoComplete and self.AutoComplete:isVisible() then
			local item = self.AutoComplete:getSelectedItem()
			if item then
				local text = self:getEntryText()
				local cmd = self.CoCo.Dispatcher:evaluate(text, nil, true)
				local alreadyComplete = cmd and cmd:getLastArgument() and cmd:getLastArgument().RawValue == item[2]
				if not alreadyComplete then
					local lastSpace = text:match("^(.*)[%s]")
					if lastSpace then
						if lastSpace ~= item[2] then
							text = lastSpace .. " " .. item[2]
						end
					else
						text = item[2]
					end
					self:setEntryText(text)
				end
			end
		end
		return
	elseif input.KeyCode == Enum.KeyCode.Tab then
		local item = self.AutoComplete:getSelectedItem()
		local text = self:getEntryText()
		if item and not (text:sub(#text, #text):match("%s") and self.AutoComplete.LastItem) then
			local replace = item[2]:gsub('"', "")
			local newText
			local insertSpace = true
			local command = self.AutoComplete.Command

			if command then
				local lastArg = self.AutoComplete.Arg

				newText = command.Alias
				insertSpace = self.AutoComplete.NumArgs ~= #command.ArgumentDefinitions
					and self.AutoComplete.IsPartial == false

				local args = command.Arguments
				for i = 1, #args do
					local arg = args[i]
					local segments = arg.RawSegments
					if arg == lastArg then
						segments[#segments] = replace
					end

					local argText = arg.Prefix .. table.concat(segments, ",")

					newText = ("%s %s"):format(newText, argText)

					if arg == lastArg then
						break
					end
				end
			else
				newText = replace
			end
			task.wait()
			self:setEntryText(newText .. (insertSpace and " " or ""))
		else
			task.wait()
			self:setEntryText(self:getEntryText())
		end
	else
		self:clearHistoryState()
	end
end

function Window:destroy()
	self.Janitor:Destroy()
	blurEffect:Destroy()
end

local function hookEvents()
	local entry = getEntry()
	if not entry then return end

	Window.Janitor:Add(entry.TextBox.FocusLost:Connect(function(submit)
		return Window:loseFocus(submit)
	end), "Disconnect")

	Window.Janitor:Add(UserInputService.InputBegan:Connect(function(input, gameProcessed)
		return Window:beginInput(input, gameProcessed)
	end), "Disconnect")

	Window.Janitor:Add(entry.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
		local gui = getGui()
		if not gui then return end
		gui.CanvasPosition = Vector2.new(0, gui.AbsoluteCanvasSize.Y)

		if entry.TextBox.Text:match("\t") then
			entry.TextBox.Text = entry.TextBox.Text:gsub("\t", "")
			return
		end

		if entry.TextBox.Text:match("^%s") then
			entry.TextBox.Text = entry.TextBox.Text:gsub("^%s+", "")
			return
		end

		if Window.OnTextChanged then
			return Window.OnTextChanged(entry.TextBox.Text)
		end
	end), "Disconnect")

	local gui = getGui()
	if gui then
		Window.Janitor:Add(gui.ChildAdded:Connect(function()
			task.defer(Window.updateWindowHeight)
		end), "Disconnect")
	end

	Window.Janitor:Add(RunService.Heartbeat:Connect(function(dt)
		local frame = getGui()
		if not frame then return end

		local slide = slideSpring:step(dt)
		local fade = fadeSpring:step(dt)
		local height = heightSpring:step(dt)
		local fov = fovSpring:step(dt)
		local blur = blurSpring:step(dt)

		frame.Position = UDim2.new(MobileSupport.IsTouchDevice and 0 or 0.025, 0, 0, BASE_Y_OFFSET + slide)
		frame.BackgroundTransparency = fade
		frame.Size = UDim2.new(MobileSupport.IsTouchDevice and 1 or 0.95, 0, 0, height)

		local camera = workspace.CurrentCamera
		if camera then
			camera.FieldOfView = fov
		end
		blurEffect.Size = blur

		if not heightSpring:idle() then
			frame.CanvasPosition = Vector2.new(0, contentHeight)
		end

		if frame.Visible then
			local textFade = math.clamp((fade - 0.4) / 0.6, 0, 1)
			for _, child in ipairs(frame:GetDescendants()) do
				if child:IsA("TextBox") or child:IsA("TextLabel") then
					child.TextTransparency = textFade
				end
			end
		end

		if slideSpring:idle() and isHiding then
			isHiding = false
			frame.Visible = false
		end
	end), "Disconnect")
end

local function getCocoGui()
	local root = Window.GuiRoot
	if not root then return nil end
	return root:FindFirstChild("CoCo")
end

local function findMobileToggle()
	local cocoGui = getCocoGui()
	if not cocoGui then return nil end
	return cocoGui:FindFirstChild("MobileToggle")
end

task.spawn(function()
	while not getGui() do
		task.wait()
	end
	hookEvents()

	mobileToggle = findMobileToggle()
	if mobileToggle then
		mobileToggle.Visible = MobileSupport.IsTouchDevice
		mobileToggle.MouseButton1Click:Connect(function()
			Window:show()
		end)
	end
end)

return Window
