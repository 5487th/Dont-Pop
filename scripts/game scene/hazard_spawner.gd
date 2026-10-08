extends Node2D
class_name HazardSpawner

enum DifficultyLevel{
	Level1,
	Level2,
	Level3
}

@export var timer:Timer
@export var bottom_boundary:Node2D

@export var difficulty_level:DifficultyLevel = DifficultyLevel.Level1
#in seconds
@export var Hazard_spawn_interval:float

var hazard_vertical_move_speed = -ProjectSettings.get_setting("global/Balloon_upward_velocity")

@export var level1_hazards:Array[PackedScene]
@export var level2_hazards:Array[PackedScene]
@export var level3_hazards:Array[PackedScene]

var spawned_hazards:Array[Node2D]

var last_spawned_hazards:Array[PackedScene] = []
var min_repeatetion_interval = 3

var elapsed_time:float = 0.0

func _ready() -> void:
	timer.wait_time=Hazard_spawn_interval
	timer.start()
	timer.timeout.connect(spawn_hazard)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	elapsed_time += delta
	
	if elapsed_time >= 180.00:
		difficulty_level = DifficultyLevel.Level3
	elif elapsed_time >= 60.00:
		difficulty_level = DifficultyLevel.Level2
	else:
		difficulty_level = DifficultyLevel.Level1
		
	spawned_hazards = spawned_hazards.filter(func(hazard):return is_instance_valid(hazard))
	for hazard in spawned_hazards:
		if hazard.global_position.y > bottom_boundary.global_position.y:
			hazard.queue_free()

func spawn_hazard():
	var hazard_to_spawn = null
	
	if difficulty_level == DifficultyLevel.Level1:
		var available_hazards = level1_hazards.filter(func(hazard_scene):return not hazard_scene in last_spawned_hazards)
		hazard_to_spawn = available_hazards.pick_random()
	elif difficulty_level == DifficultyLevel.Level2:
		var available_hazards = level2_hazards.filter(func(hazard_scene):return not hazard_scene in last_spawned_hazards)
		hazard_to_spawn = available_hazards.pick_random()
	elif difficulty_level == DifficultyLevel.Level3:
		var available_hazards = level3_hazards.filter(func(hazard_scene):return not hazard_scene in last_spawned_hazards)
		hazard_to_spawn = available_hazards.pick_random()
		
	if not hazard_to_spawn:
		return
		
	var hazard:Hazard = hazard_to_spawn.instantiate()
	
	if len(last_spawned_hazards) >= min_repeatetion_interval:
		last_spawned_hazards.remove_at(0)
	last_spawned_hazards.append(hazard_to_spawn)
		
	hazard.position = Vector2(global_position.x, - hazard.vertical_length/2)
	hazard.vertical_velocity = hazard_vertical_move_speed
	
	add_child(hazard)
	spawned_hazards.append(hazard)
	
	
	timer.wait_time = abs(hazard.vertical_length)/hazard_vertical_move_speed + Hazard_spawn_interval
	timer.start()
