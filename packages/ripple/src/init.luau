local config = require("./config")
local easing = require("./easing")
local motion = require("./motion")
local spring = require("./spring")
local tween = require("./tween")
local types = require("./types")

export type Animatable = types.Animatable
export type AnimatableType = types.AnimatableType
export type AnimatablePrimitive = types.AnimatablePrimitive
export type Easing = easing.Easing

export type Motion<T = any> = motion.Motion<T>
export type MotionOptions<T = any> = motion.MotionOptions<T>
export type Spring<T = any> = spring.Spring<T>
export type SpringOptions<T = any> = spring.SpringOptions<T>
export type Tween<T = any> = tween.Tween<T>
export type TweenOptions<T = any> = tween.TweenOptions<T>

return {
	config = config,
	easing = easing,
	createMotion = motion.createMotion,
	motionScheduler = motion.scheduler,
	createSpring = spring.createSpring,
	springScheduler = spring.scheduler,
	createTween = tween.createTween,
	tweenScheduler = tween.scheduler,
}
