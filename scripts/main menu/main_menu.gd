extends Node2D

@export var play_button:TextureButton
@export var start_button:TextureButton
@export var back_button:Button
@export var transition_exit:SceneTransition
@export var transition_enter:SceneTransition

@export var main_screen:CanvasLayer
@export var customization_screen:CanvasLayer

@export var click_sound_player:AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not SceneManager.main_menu_being_opened_first_time:
		transition_enter.visible = true
		transition_enter.fade_out()
	else:
		transition_enter.visible = false
		
	main_screen.visible = true
	customization_screen.visible = false
	play_button.pressed.connect(play_pressed)
	start_button.pressed.connect(start_pressed)
	back_button.pressed.connect(back_button_pressed)
	

func play_pressed():
	click_sound_player.play()
	
	main_screen.visible = false
	customization_screen.visible = true
	
	click_sound_player.play()
	

func start_pressed():
	click_sound_player.play()
	
	transition_exit.fade_in()
	if transition_exit.animation_player.is_playing():
		await transition_exit.animation_player.animation_finished
	
	SceneManager.change_to_main_game_scene()

func back_button_pressed():
	click_sound_player.play()
	
	main_screen.visible = true
	customization_screen.visible = false
	
