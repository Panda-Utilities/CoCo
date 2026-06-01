--!strict
local Services = require("../Shared/Services")

local FONT_URL = "https://github.com/Panda-Utilities/Storage/raw/refs/heads/main/ProggyClean.ttf"

local Fonts = {} :: {
	ProggyClean: Font?,
	Loaded: boolean,
	Get: (() -> (Enum.Font, Font?)),
	Apply: ((TextLabel | TextButton | TextBox) -> ()),
	OnLoaded: ((() -> ()) -> ()),
}

Fonts.ProggyClean = nil
Fonts.Loaded = false

local loadedCallbacks: { (() -> ()) } = {}

local function canLoadCustomFonts(): boolean
	return type(writefile) == "function" and type(isfile) == "function" and type(getcustomasset) == "function"
end

function Fonts.Get(): (Enum.Font, Font?)
	if Fonts.ProggyClean then
		return Enum.Font.Code, Fonts.ProggyClean
	end
	return Enum.Font.Code, nil
end

function Fonts.Apply(label: TextLabel | TextButton | TextBox)
	local fontEnum, fontFace = Fonts.Get()
	label.Font = fontEnum
	if fontFace then
		label.FontFace = fontFace
	end
end

function Fonts.OnLoaded(callback: () -> ())
	if Fonts.Loaded then
		task.spawn(callback)
	else
		loadedCallbacks[#loadedCallbacks + 1] = callback
	end
end

local function loadFont()
	if not canLoadCustomFonts() then
		Fonts.Loaded = true
		return
	end

	local okDownload, data = pcall(function()
		return game:HttpGet(FONT_URL)
	end)
	if not okDownload or not data or data == "" then return end
	if not pcall(writefile, "ProggyClean.ttf", data) then return end

	local okConfig = pcall(function()
		local config = {
			name = "ProggyClean",
			faces = {
				{
					name = "Regular",
					weight = 400,
					style = "normal",
					assetId = getcustomasset("ProggyClean.ttf"),
				},
			},
		}
		writefile("ProggyClean.ttf.json", Services.HttpService:JSONEncode(config))
	end)
	if not okConfig then return end

	local okLoad, font = pcall(Font.new, getcustomasset("ProggyClean.ttf.json"), Enum.FontWeight.Regular)
	if okLoad and font then
		Fonts.ProggyClean = font
	end
end

function Fonts.LoadAll()
	loadFont()
	Fonts.Loaded = true

	for _, callback in loadedCallbacks do
		callback()
	end
end

task.spawn(function()
	task.wait(1)
	Fonts.LoadAll()
end)

return Fonts
