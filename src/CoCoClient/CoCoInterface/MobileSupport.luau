local UserInputService = game:GetService("UserInputService")

return {
	IsTouchDevice = rawget(_G, "__COCO_MOBILE_TEST") or UserInputService.TouchEnabled,
}
