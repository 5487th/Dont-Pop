extends Node2D
class_name BalloonSpawner

@export var balloon_scene:PackedScene

var balloon_1:Balloon
var balloon_2:Balloon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	balloon_1 = balloon_scene.instantiate()
	balloon_2 = balloon_scene.instantiate()
	
	balloon_1.position = Vector2(-100, 100)
	balloon_2.position = Vector2(100, 100)
	
	balloon_1.balloon_color = BalloonInfo.balloon_color_1
	balloon_2.balloon_color = BalloonInfo.balloon_color_2
	
	add_child(balloon_1)
	add_child(balloon_2)
	
	balloon_1.balloon_number = Balloon.BalloonNumber.Balloon_1
	balloon_2.balloon_number = Balloon.BalloonNumber.Balloon_2
