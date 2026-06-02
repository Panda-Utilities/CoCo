--!strict

export type Colors = {
	BackgroundDark: Color3,
	BackgroundMedium: Color3,
	BackgroundLight: Color3,
	TextPrimary: Color3,
	TextAccent: Color3,
	TextHighlight: Color3,
	TextSecondary: Color3,
	AutocompleteItem: Color3,
	HelpOrange: Color3,
	HelpGray: Color3,
	Stroke: Color3,
}

export type Gui = {
	HistoryFile: string,
	ConfigFile: string,
	DefaultTextSize: number,
	ScrollBarThickness: number,
	EntryLayoutOrder: number,
	BackgroundTransparency: number,
	AutocompleteBackgroundTransparency: number,
	SectionBackgroundTransparency: number,
	DefaultPadding: number,
}

export type Argument = {
	KeywordResolverMaxDepth: number,
}

local Config: {
	Colors: Colors,
	Gui: Gui,
	Argument: Argument,
	GuiRoot: Instance?,
} = {
	GuiRoot = nil,
	Colors = {
		BackgroundDark = Color3.fromRGB(17, 17, 17),
		BackgroundMedium = Color3.fromRGB(59, 59, 59),
		BackgroundLight = Color3.fromRGB(230, 230, 230),
		TextPrimary = Color3.fromRGB(255, 255, 255),
		TextAccent = Color3.fromRGB(255, 223, 93),
		TextHighlight = Color3.fromRGB(230, 126, 34),
		TextSecondary = Color3.fromRGB(131, 222, 255),
		AutocompleteItem = Color3.fromRGB(131, 222, 255),
		HelpOrange = Color3.fromRGB(230, 126, 34),
		HelpGray = Color3.fromRGB(230, 230, 230),
		Stroke = Color3.fromRGB(30, 30, 30),
	},

	Gui = {
		HistoryFile = "CoCo/History",
	ConfigFile = "CoCo/Config",
	PluginDir = "CoCo/Plugins",
	DefaultTextSize = 14,
		ScrollBarThickness = 6,
		EntryLayoutOrder = 999999999,
		BackgroundTransparency = 0.4,
		AutocompleteBackgroundTransparency = 0.5,
		SectionBackgroundTransparency = 0.2,
		DefaultPadding = 10,
	},

	Argument = {
		KeywordResolverMaxDepth = 20,
	},
}

return Config
