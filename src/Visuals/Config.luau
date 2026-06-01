--!strict
local Signal = require("../../packages/goodsignal")

export type FeatureKey = "box" | "box fill" | "name" | "health bar" | "health text" | "distance" | "tool text" | "highlight"

export type Esp = {
	Enabled: boolean,
	ShowEnemies: boolean,
	ShowFriendlies: boolean,
	ShowNeutral: boolean,
	ShowLocal: boolean,
	ShowTarget: boolean,
	TeamCheck: boolean,
	UseTeamColors: boolean,
	MaxDistance: number,
	UseDisplayName: boolean,
	LimitFPS: number,
	Features: { [string]: boolean },
	ShowOn: { [string]: { string } },
	TeamColors: { [string]: { [string]: Color3 } },
	TeamTransparencies: { [string]: { [string]: number } },
	UniversalColors: { [string]: Color3 },
	TextCasing: string,
	ToolTextCasing: string,
	HealthBarGap: number,
	HealthBarWidth: number,
	HealthBarOutline: number,
	HealthBarYOffset: number,
	HideFullHealthText: boolean,
	HealthBarGradientDirection: string,
	HighlightBehindWalls: boolean,
	HighlightTransparency: number,
	HighlightOutlineColor: Color3,
	HighlightOutlineTransparency: number,
	DynamicBoxes: boolean,
	DynamicBoxesCheap: boolean,
	DynamicBoxesIncludeAll: boolean,
	Changed: Signal.Signal<()>,
}

local DEFAULT_SHOW_ON = { "neutral", "friendly", "enemy", "local", "target" }

local function create(): Esp
	return {
		Enabled = false,
		ShowEnemies = true,
		ShowFriendlies = true,
		ShowNeutral = true,
		ShowLocal = false,
		ShowTarget = true,
		TeamCheck = false,
		UseTeamColors = false,
		MaxDistance = 2500,
		UseDisplayName = false,
		LimitFPS = 0,
		Features = {
			["box"] = true,
			["box fill"] = false,
			["name"] = true,
			["health bar"] = true,
			["health text"] = true,
			["distance"] = true,
			["tool text"] = false,
			["highlight"] = false
		},
		ShowOn = {
			["box"] = DEFAULT_SHOW_ON,
			["box fill"] = DEFAULT_SHOW_ON,
			["name"] = DEFAULT_SHOW_ON,
			["health bar"] = DEFAULT_SHOW_ON,
			["health text"] = DEFAULT_SHOW_ON,
			["distance"] = DEFAULT_SHOW_ON,
			["tool text"] = DEFAULT_SHOW_ON,
			["highlight"] = DEFAULT_SHOW_ON
		},
		TeamColors = {
			neutral = {
				["box"] = Color3.fromRGB(255, 255, 255),
				["box fill"] = Color3.fromRGB(255, 255, 255),
				["name"] = Color3.fromRGB(255, 255, 255),
				["health bar"] = Color3.fromRGB(0, 255, 0),
				["health text"] = Color3.fromRGB(255, 255, 255),
				["distance"] = Color3.fromRGB(255, 255, 255),
				["tool text"] = Color3.fromRGB(255, 255, 255),
				["highlight"] = Color3.fromRGB(0, 0, 0)
			},
			friendly = {
				["box"] = Color3.fromRGB(120, 200, 255),
				["box fill"] = Color3.fromRGB(120, 200, 255),
				["name"] = Color3.fromRGB(120, 200, 255),
				["health bar"] = Color3.fromRGB(120, 200, 255),
				["health text"] = Color3.fromRGB(120, 200, 255),
				["distance"] = Color3.fromRGB(120, 200, 255),
				["tool text"] = Color3.fromRGB(120, 200, 255),
				["highlight"] = Color3.fromRGB(120, 200, 255)
			},
			enemy = {
				["box"] = Color3.fromRGB(255, 120, 120),
				["box fill"] = Color3.fromRGB(255, 120, 120),
				["name"] = Color3.fromRGB(255, 120, 120),
				["health bar"] = Color3.fromRGB(255, 120, 120),
				["health text"] = Color3.fromRGB(255, 120, 120),
				["distance"] = Color3.fromRGB(255, 120, 120),
				["tool text"] = Color3.fromRGB(255, 120, 120),
				["highlight"] = Color3.fromRGB(255, 120, 120)
			},
			["local"] = {
				["box"] = Color3.fromRGB(255, 255, 120),
				["box fill"] = Color3.fromRGB(255, 255, 120),
				["name"] = Color3.fromRGB(255, 255, 120),
				["health bar"] = Color3.fromRGB(255, 255, 120),
				["health text"] = Color3.fromRGB(255, 255, 120),
				["distance"] = Color3.fromRGB(255, 255, 120),
				["tool text"] = Color3.fromRGB(255, 255, 120),
				["highlight"] = Color3.fromRGB(255, 255, 120)
			},
			target = {
				["box"] = Color3.fromRGB(193, 91, 91),
				["box fill"] = Color3.fromRGB(193, 91, 91),
				["name"] = Color3.fromRGB(193, 91, 91),
				["health bar"] = Color3.fromRGB(193, 91, 91),
				["health text"] = Color3.fromRGB(193, 91, 91),
				["distance"] = Color3.fromRGB(193, 91, 91),
				["tool text"] = Color3.fromRGB(193, 91, 91),
				["highlight"] = Color3.fromRGB(193, 91, 91)
			}
		},
		TeamTransparencies = {
			neutral = {
				["box"] = 0,
				["box fill"] = 0.85,
				["name"] = 0,
				["health bar"] = 0,
				["health text"] = 0,
				["distance"] = 0,
				["tool text"] = 0,
				["highlight"] = 0.9
			},
			friendly = {
				["box"] = 0,
				["box fill"] = 0.85,
				["name"] = 0,
				["health bar"] = 0,
				["health text"] = 0,
				["distance"] = 0,
				["tool text"] = 0,
				["highlight"] = 0.9
			},
			enemy = {
				["box"] = 0,
				["box fill"] = 0.85,
				["name"] = 0,
				["health bar"] = 0,
				["health text"] = 0,
				["distance"] = 0,
				["tool text"] = 0,
				["highlight"] = 0.9
			},
			["local"] = {
				["box"] = 0,
				["box fill"] = 0.85,
				["name"] = 0,
				["health bar"] = 0,
				["health text"] = 0,
				["distance"] = 0,
				["tool text"] = 0,
				["highlight"] = 0.9
			},
			target = {
				["box"] = 0,
				["box fill"] = 0.85,
				["name"] = 0,
				["health bar"] = 0,
				["health text"] = 0,
				["distance"] = 0,
				["tool text"] = 0,
				["highlight"] = 0.9
			}
		},
		UniversalColors = {
			neutral = Color3.fromRGB(255, 255, 255),
			friendly = Color3.fromRGB(120, 200, 255),
			enemy = Color3.fromRGB(255, 120, 120),
			["local"] = Color3.fromRGB(255, 255, 120),
			target = Color3.fromRGB(193, 91, 91)
		},
		TextCasing = "normal",
		ToolTextCasing = "lowercase",
		HealthBarGap = 3,
		HealthBarWidth = 2,
		HealthBarOutline = 1,
		HealthBarYOffset = -2,
		HideFullHealthText = false,
		HealthBarGradientDirection = "darker",
		HighlightBehindWalls = true,
		HighlightTransparency = 0.9,
		HighlightOutlineColor = Color3.fromRGB(255, 255, 255),
		HighlightOutlineTransparency = 0.2,
		DynamicBoxes = true,
		DynamicBoxesCheap = true,
		DynamicBoxesIncludeAll = false,
		Changed = Signal.new()
	}
end

return {
	create = create,
}
