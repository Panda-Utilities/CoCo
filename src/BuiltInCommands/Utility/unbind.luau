--!strict
return {
	Name = "unbind",
	Aliases = {},
	Description = "Unbinds a key combination previously bound with Bind.",
	Group = "DefaultUtil",
	Args = {
		{
			Type = "keycombo",
			Name = "Combo",
			Description = "The key combination to unbind (e.g. F2, Ctrl+F). Use 'bind list' to see all.",
		},
	},

	ClientRun = function(context, combo)
		if not combo then
			return "Invalid key combination."
		end

		local binds = context:getStore("COCO_Binds")
		local comboText = combo.text

		local data = binds[comboText]
		if data and data.connections then
			for _, conn in ipairs(data.connections) do
				conn:Disconnect()
			end
			if data.heartbeat then
				data.heartbeat:Disconnect()
			end
			binds[comboText] = nil
			return ("Unbound %q."):format(comboText)
		end

		if binds[combo.key] then
			binds[combo.key]:Disconnect()
			binds[combo.key] = nil
			return ("Unbound %q."):format(comboText)
		end

		return ("%q is not bound."):format(comboText)
	end,
}
