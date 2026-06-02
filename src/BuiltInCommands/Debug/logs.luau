local logsActive = false
local logConnection = nil
local logGui = nil

local function createLogWindow()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "CoCoLogViewer"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 400, 0, 300)
	frame.Position = UDim2.new(0.5, -200, 0, 50)
	frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
	frame.BackgroundTransparency = 0.3
	frame.BorderSizePixel = 0
	frame.Active = true
	frame.Draggable = true
	frame.Parent = screenGui

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 24)
	title.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
	title.BackgroundTransparency = 0.5
	title.BorderSizePixel = 0
	title.Text = "CoCo Logs (Chat)"
	title.TextColor3 = Color3.new(1, 1, 1)
	title.TextSize = 14
	title.Font = Enum.Font.Code
	title.Parent = frame

	local list = Instance.new("ScrollingFrame")
	list.Size = UDim2.new(1, 0, 1, -24)
	list.Position = UDim2.new(0, 0, 0, 24)
	list.BackgroundTransparency = 1
	list.BorderSizePixel = 0
	list.CanvasSize = UDim2.new(0, 0, 0, 0)
	list.ScrollBarThickness = 4
	list.AutomaticCanvasSize = Enum.AutomaticSize.Y
	list.Parent = frame

	local uiList = Instance.new("UIListLayout")
	uiList.Parent = list
	uiList.SortOrder = Enum.SortOrder.LayoutOrder

	local function addEntry(text)
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, -4, 0, 18)
		label.Position = UDim2.new(0, 2, 0, 0)
		label.BackgroundTransparency = 1
		label.BorderSizePixel = 0
		label.Text = text
		label.TextColor3 = Color3.new(0.8, 0.8, 1)
		label.TextSize = 12
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Font = Enum.Font.Code
		label.RichText = true
		label.Parent = list
	end

	return screenGui, addEntry
end

return {
	Name = "logs";
	Aliases = {};
	InverseAliases = {"unlogs", "nologs"};
	Description = "Toggle chat log viewer window.";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not logsActive then return "Log viewer already closed." end
			if logConnection then
				logConnection:Disconnect()
				logConnection = nil
			end
			if logGui then
				logGui:Destroy()
				logGui = nil
			end
			logsActive = false
			return "Log viewer closed."
		end

		if logsActive then
			if logGui then
				logGui:Destroy()
				logGui = nil
			end
			if logConnection then
				logConnection:Disconnect()
				logConnection = nil
			end
			logsActive = false
			return "Log viewer closed."
		end

		local gui, addEntry = createLogWindow()
		gui.Parent = context.Executor:WaitForChild("PlayerGui")
		logGui = gui

		addEntry("<b>Log viewer started.</b>")

		logConnection = context.Executor.Chatted:Connect(function(message)
			addEntry(("%s: %s"):format(context.Executor.Name, message))
		end)

		logsActive = true
		return "Log viewer opened."
	end;
}
