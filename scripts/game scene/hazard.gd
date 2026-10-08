extends Node2D
class_name Hazard

@export var vertical_length:float
var vertical_velocity:float

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	move_hazard()

func move_hazard():
	if not ProjectSettings.get_setting("global/stop_balloon_rising_up"):
		position.y += vertical_velocity * get_process_delta_time()
