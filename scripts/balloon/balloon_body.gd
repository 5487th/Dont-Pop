extends CharacterBody2D
class_name BalloonMovementManager

@export var balloon:Balloon

@export var can_move:bool = true
@export var tilt:bool = true
@export var wave:bool = true
@export var bounse:bool = true
@export var push:bool = true


const SPEED = 300.0
const DECELERATION = 7
const ACCELERATION = 20

#in degrees
const TILT_AMOUNT = 10
const TILT_SPEED = 0.5

#1 means full energy is retained 0 means no bounce
const BOUNSINESS = 0.8

const WAVE_AMPLITUDE = 0.1
const WAVE_FREQUENCY = 1.0

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("player1_left","player1_right","player1_up","player1_down")
	if balloon.balloon_number == Balloon.BalloonNumber.Balloon_2:
		direction = Input.get_vector("player2_left","player2_right","player2_up","player2_down")
	
	
	
	if direction and can_move:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION)
		
		if direction.x > deg_to_rad(0) and tilt:
			rotation = move_toward(rotation, deg_to_rad(TILT_AMOUNT), deg_to_rad(TILT_SPEED))
		elif direction.x < deg_to_rad(0) and tilt:
			rotation = move_toward(rotation, deg_to_rad(-TILT_AMOUNT), deg_to_rad(TILT_SPEED))
		elif tilt:
			rotation = move_toward(rotation, deg_to_rad(0), deg_to_rad(TILT_SPEED))
	else:
		if tilt:
			rotation = move_toward(rotation, deg_to_rad(0), deg_to_rad(TILT_SPEED))
		velocity = velocity.move_toward(Vector2(0, 0), DECELERATION)
		
		#waving
		if wave:
			position.y = position.y + sin(Time.get_ticks_msec()/1000.0 * WAVE_FREQUENCY) * WAVE_AMPLITUDE
			position.x = position.x + sin(Time.get_ticks_msec()/1000.0 * WAVE_FREQUENCY) * WAVE_AMPLITUDE
	move_and_slide()
	
	#bouncing
	if get_slide_collision_count() > 0 and bounse:
		# Get data from the first collision this frame
		var collision = get_slide_collision(0)
		
		if collision.get_collider() is BalloonMovementManager and push:
			var body:BalloonMovementManager = collision.get_collider()
			body.velocity = -collision.get_normal() * velocity.length()/2
