--!strict
local TypeUtils = require("../Shared/TypeUtils")
local Signal = require("../../packages/goodsignal")

return function(coco, gui)
	local Interface = require("./CoCoInterface")(coco, gui)

	coco.ActivationKeys = { [Enum.KeyCode.F2] = true }
	coco.Enabled = true
	coco.MashToEnable = false
	coco.ActivationUnlocksMouse = false
	coco.HideOnLostFocus = true
	coco.PlaceName = "CoCo"
	coco.Events = {
		AddLine = Signal.new(),
		Message = Signal.new(),
	}

	function coco:setActivationKeys(keysArray)
		self.ActivationKeys = TypeUtils.makeDictionary(keysArray)
	end

	function coco:setPlaceName(name)
		self.PlaceName = name
		Interface.Window:updateLabel()
	end

	function coco:setEnabled(enabled)
		self.Enabled = enabled
	end

	function coco:setActivationUnlocksMouse(enabled)
		self.ActivationUnlocksMouse = enabled
	end

	function coco:show()
		if not self.Enabled then return end
		Interface.Window:show()
	end

	function coco:hide()
		Interface.Window:hide()
	end

	function coco:toggle()
		if not self.Enabled then return self:hide() end
		Interface.Window:setVisible(not Interface.Window:isVisible())
	end

	function coco:setMashToEnable(isEnabled)
		self.MashToEnable = isEnabled
		if isEnabled then self:setEnabled(false) end
	end

	function coco:setHideOnLostFocus(enabled)
		self.HideOnLostFocus = enabled
	end

	function coco:handleEvent(name, callback)
		if self.Events[name] then
			return self.Events[name]:Connect(callback)
		end
	end

	local _ = require("./DefaultEventHandlers")(coco, gui)

	return Interface
end
