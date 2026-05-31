--!strict
return {
	Name = "version",
	Args = {},
	Description = "Shows the current version of CoCo",
	Group = "DefaultDebug",

	Run = function()
		return ("CoCo Version %s"):format(_P.vers)
	end,
}
