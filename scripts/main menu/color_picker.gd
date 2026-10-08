extends Panel
class_name BalloonColorPicker

@export var balloon_number:Balloon.BalloonNumber

@export var current_color:Balloon.BalloonColor

@export var balloon_display:TextureRect
@export var color_display:ColorRect

@export var other_color_picker:BalloonColorPicker

@export var left_button:Button
@export var right_button:Button

@export var click_sound_player:AudioStreamPlayer2D

var available_colors = Balloon.BalloonColor.values()

func _ready() -> void:
	update_available_colors()
	
	#changes its color if its color matches with the other color pickers color
	if current_color == other_color_picker.current_color:
		current_color = available_colors.pick_random()
	
	update_color_displays()
	
	if balloon_number == Balloon.BalloonNumber.Balloon_1:
		BalloonInfo.balloon_color_1 = current_color
	elif balloon_number == Balloon.BalloonNumber.Balloon_2:
		BalloonInfo.balloon_color_2 = current_color
	
	#connect events
	left_button.pressed.connect(left_button_pressed)
	right_button.pressed.connect(right_button_pressed)
	
func update_color_displays():
	balloon_display.modulate = Balloon.get_color(current_color)
	color_display.modulate = Balloon.get_color(current_color)

func update_available_colors():
	available_colors = Balloon.BalloonColor.values()
	available_colors.erase(other_color_picker.current_color)

func left_button_pressed():
	click_sound_player.play()
	update_available_colors()
	
	var current_index = available_colors.find(current_color)
	var next_index = (current_index - 1) % len(available_colors)
	
	current_color = available_colors[next_index]
	
	if balloon_number == Balloon.BalloonNumber.Balloon_1:
		BalloonInfo.balloon_color_1 = current_color
	elif balloon_number == Balloon.BalloonNumber.Balloon_2:
		BalloonInfo.balloon_color_2 = current_color
	
	update_color_displays()

func right_button_pressed():
	click_sound_player.play()
	update_available_colors()
	
	var current_index = available_colors.find(current_color)
	var next_index = (current_index + 1) % len(available_colors)
	
	current_color = available_colors[next_index]
	
	if balloon_number == Balloon.BalloonNumber.Balloon_1:
		BalloonInfo.balloon_color_1 = current_color
	elif balloon_number == Balloon.BalloonNumber.Balloon_2:
		BalloonInfo.balloon_color_2 = current_color
	
	update_color_displays()
