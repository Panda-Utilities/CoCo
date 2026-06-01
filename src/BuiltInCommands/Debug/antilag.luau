--!strict
local Services = require("../../Shared/Services")
local Lighting = Services.Lighting

local antilagEnabled = false
local antilagConnection = nil

local function disableAntilag()
	antilagEnabled = false
	if antilagConnection then
		antilagConnection:Disconnect()
		antilagConnection = nil
	end

	Lighting.GlobalShadows = true
	Lighting.FogEnd = 100000
	Lighting.FogStart = 0
	settings().Rendering.QualityLevel = 21
end

return {
	Name = "antilag";
	Aliases = {"boostfps", "lowgraphics"};
	InverseAliases = {"unantilag"};
	Description = "Toggle anti-lag (lower graphics, disable shadows, etc.).";
	Group = "DefaultDebug";
	Args = {};

	ClientRun = function(context)
		if context:isInvertedCall() then
			if not antilagEnabled then return "Anti-lag already disabled." end
			disableAntilag()
			return "Anti-lag disabled."
		end

		if antilagEnabled then
			disableAntilag()
			return "Anti-lag disabled."
		end

		antilagEnabled = true

		local terrain = workspace:FindFirstChildWhichIsA("Terrain")
		if terrain then
			terrain.WaterWaveSize = 0
			terrain.WaterWaveSpeed = 0
			terrain.WaterReflectance = 0
			terrain.WaterTransparency = 1
		end

		Lighting.GlobalShadows = false
		Lighting.FogEnd = 9e9
		Lighting.FogStart = 9e9
		settings().Rendering.QualityLevel = 1

		local function apply()
			for _, v in ipairs(game:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CastShadow = false
					v.Material = Enum.Material.Plastic
					v.Reflectance = 0
				elseif v:IsA("Decal") then
					v.Transparency = 1
					v.Texture = ""
				elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
					v.Lifetime = NumberRange.new(0)
				end
			end

			for _, v in ipairs(Lighting:GetDescendants()) do
				if v:IsA("PostEffect") then
					v.Enabled = false
				end
			end
		end

		apply()

		antilagConnection = workspace.DescendantAdded:Connect(function(child)
			task.spawn(function()
				task.wait()
				if not antilagEnabled then return end
				if child:IsA("BasePart") then
					child.CastShadow = false
					child.Material = Enum.Material.Plastic
					child.Reflectance = 0
				elseif child:IsA("Decal") then
					child.Transparency = 1
					child.Texture = ""
				elseif child:IsA("ParticleEmitter") or child:IsA("Trail") then
					child.Lifetime = NumberRange.new(0)
				end
			end)
		end)

		return "Anti-lag enabled."
	end;
}
