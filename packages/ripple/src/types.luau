export type AnimatablePrimitive = number | vector

export type AnimatableType = AnimatablePrimitive

export type Animatable = AnimatableType | { [any]: AnimatablePrimitive }

return {}
