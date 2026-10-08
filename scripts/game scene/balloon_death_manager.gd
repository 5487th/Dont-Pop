extends Node2D
class_name BallonDeathManager

@export var ballon_spawner:BalloonSpawner
@export var transition:SceneTransition
@export var death_sound_player:AudioStreamPlayer2D

@export var camera:ScreenShake

var balloon_1:Balloon
var balloon_2:Balloon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ProjectSettings.set_setting("global/stop_balloon_rising_up", false)
	
	transition.fade_out()
	
	if not ballon_spawner.is_node_ready():
		await ballon_spawner.ready
	
	balloon_1 = ballon_spawner.balloon_1
	balloon_2 = ballon_spawner.balloon_2
	
	balloon_1.balloon_health.ballon_died.connect(ballon_died)
	balloon_2.balloon_health.ballon_died.connect(ballon_died)
	
func ballon_died(balloon_number):
	death_sound_player.play()
	camera.apply_shake()
	
	if balloon_number == Balloon.BalloonNumber.Balloon_1:
		BalloonInfo.winner = Balloon.BalloonNumber.Balloon_2
		
		balloon_1.queue_free()
		
		if is_instance_valid(balloon_2):
			balloon_2.balloon_health.can_die = false
			balloon_2.balloon_movement.can_move = false
			balloon_2.balloon_movement.tilt = false
		
		ProjectSettings.set_setting("global/stop_balloon_rising_up", true)
		
		await get_tree().create_timer(2.0).timeout
		
		transition.fade_in()
		if transition.animation_player.is_playing():
			await transition.animation_player.animation_finished
		
		SceneManager.change_to_replay_menu_scene()
		
	elif balloon_number == Balloon.BalloonNumber.Balloon_2:
		BalloonInfo.winner = Balloon.BalloonNumber.Balloon_1
		
		balloon_2.queue_free()
		
		if is_instance_valid(balloon_1):
			balloon_1.balloon_health.can_die = false
			balloon_1.balloon_movement.can_move = false
			balloon_1.balloon_movement.tilt = false
		
		ProjectSettings.set_setting("global/stop_balloon_rising_up", true)
		
		await get_tree().create_timer(2.0).timeout
		
		transition.fade_in()
		if transition.animation_player.is_playing():
			await transition.animation_player.animation_finished
			
		SceneManager.change_to_replay_menu_scene()
