extends Node

var main_menu_scene = load("res://scenes/main_menu.tscn")
var main_game_scene = load("res://scenes/main_game.tscn")
var replay_menu_scene = load("res://scenes/replay_menu.tscn")

@export var main_menu_being_opened_first_time = true

func change_to_main_game_scene():
	get_tree().change_scene_to_packed(main_game_scene)

func change_to_main_menu_scene():
	get_tree().change_scene_to_packed(main_menu_scene)
	main_menu_being_opened_first_time = false

func change_to_replay_menu_scene():
	get_tree().change_scene_to_packed(replay_menu_scene)
