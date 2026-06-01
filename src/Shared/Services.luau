--!strict
local cloneref = cloneref or function(instance) return instance end

local services = {
	UserInputService = cloneref(game:GetService("UserInputService")),
	RunService = cloneref(game:GetService("RunService")),
	GuiService = cloneref(game:GetService("GuiService")),
	Players = cloneref(game:GetService("Players")),
	Teams = cloneref(game:GetService("Teams")),
	TextChatService = cloneref(game:GetService("TextChatService")),
	TextService = cloneref(game:GetService("TextService")),
	HttpService = cloneref(game:GetService("HttpService")),
	StarterGui = cloneref(game:GetService("StarterGui")),
	CoreGui = cloneref(game:GetService("CoreGui")),
	Lighting = cloneref(game:GetService("Lighting")),
	TweenService = cloneref(game:GetService("TweenService")),
	Workspace = cloneref(game:GetService("Workspace")),
	PathfindingService = cloneref(game:GetService("PathfindingService")),
}

return services
