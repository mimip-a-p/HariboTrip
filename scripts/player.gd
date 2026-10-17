extends CharacterBody2D

const GRAVITY : int = 4200
const JUMP_SPEED : int = -900

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_SPEED
			
	move_and_slide()
