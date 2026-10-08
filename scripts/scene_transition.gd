extends Node2D
class_name SceneTransition

@export var animation_player:AnimationPlayer

func fade_in():
	animation_player.play("fade_in")
	
func fade_out():
	animation_player.play("fade_in", -1, -1.0, true)

func set_to_end():
	animation_player.seek(animation_player.get_animation("fade_in").length, true)

func set_to_start():
	animation_player.seek(animation_player.get_animation("fade_in").length, true)
