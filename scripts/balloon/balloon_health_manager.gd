extends Area2D
class_name BalloonHealthManager

@export var ballon:Balloon

var can_die:bool = true


signal ballon_died(ballon_number:Balloon.BalloonNumber)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_body_entered)
	area_entered.connect(_body_entered)

func _body_entered(body:Node):
	if body is not BalloonMovementManager and can_die:
		ballon_died.emit(ballon.balloon_number)
