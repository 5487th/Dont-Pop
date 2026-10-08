extends Camera2D
class_name ScreenShake

@export var randomStrength:float = 30.0
@export var shakeFade = 5.0

var RNG = RandomNumberGenerator.new()

var shake_strength:float = 0.0

func apply_shake():
	shake_strength = randomStrength

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		apply_shake()
	
	if shake_strength > 0:
		shake_strength = lerp(shake_strength, 0.0, shakeFade * delta)
	
		offset = randomOffset()
func randomOffset():
	return Vector2(RNG.randf_range(-shake_strength, shake_strength), RNG.randf_range(-shake_strength, shake_strength))
