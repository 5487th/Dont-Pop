extends Node2D
class_name Balloon

enum BalloonNumber{
	Balloon_1,
	Balloon_2,
}

enum BalloonColor{
	WHITE,
	BLACK,
	RED,
	GREEN,
	BLUE,
	YELLOW,
	PINK,
	ORANGE,
}

@export var ballon_visual:Sprite2D
@export var balloon_movement:BalloonMovementManager
@export var balloon_health:BalloonHealthManager

@export var balloon_number:BalloonNumber = BalloonNumber.Balloon_1
@export var balloon_color:BalloonColor = BalloonColor.WHITE

func _ready() -> void:
	match balloon_color:
		BalloonColor.WHITE:
			ballon_visual.modulate = Color.WHITE
		BalloonColor.BLACK:
			ballon_visual.modulate = Color.BLACK
		BalloonColor.RED:
			ballon_visual.modulate = Color('DC143C')
			
		BalloonColor.GREEN:
			ballon_visual.modulate = Color("259645ff")
			
		BalloonColor.BLUE:
			ballon_visual.modulate = Color('#4169E1')
			
		BalloonColor.YELLOW:
			ballon_visual.modulate = Color("e5d900ff")
			
		BalloonColor.PINK:
			ballon_visual.modulate = Color.HOT_PINK
			
		BalloonColor.ORANGE:
			ballon_visual.modulate = Color.DARK_ORANGE
		_:
			ballon_visual.modulate = Color.WHITE
	
@warning_ignore("shadowed_variable")
static func get_color(balloon_color:BalloonColor):
	match balloon_color:
		BalloonColor.WHITE:
			return Color.WHITE
		BalloonColor.BLACK:
			return Color.BLACK
		BalloonColor.RED:
			return Color('DC143C')
			
		BalloonColor.GREEN:
			return Color("259645ff")
			
		BalloonColor.BLUE:
			return Color('#4169E1')
			
		BalloonColor.YELLOW:
			return Color("e5d900ff")
			
		BalloonColor.PINK:
			return Color.HOT_PINK
			
		BalloonColor.ORANGE:
			return Color.DARK_ORANGE
		_:
			return Color.WHITE
