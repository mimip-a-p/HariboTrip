extends CharacterBody2D

const GRAVITY : int = 3400
const JUMP_SPEED : int = -900

var air_time := 0.0

func _ready() -> void:
	floor_snap_length = 16.0
	floor_constant_speed = true

func _physics_process(delta):
	velocity.y += GRAVITY * delta

	if is_on_floor():
		air_time = 0.0
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_SPEED
	else:
		air_time += delta

	move_and_slide()
	$Animation.update_animation(delta)
