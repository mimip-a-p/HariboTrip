extends CharacterBody2D

@export var screen_offset_x: float = 220.0

@onready var ray_cast = $RayCast2D
@onready var player = get_parent().find_child("Character")

var direction = Vector2.RIGHT

func _process(_delta):
	# Boss stays in place while scrolling ground
	var cam := get_viewport().get_camera_2d()
	if cam:
		global_position.x = cam.global_position.x + screen_offset_x
		
	direction = (player.position - global_position).normalized()
	ray_cast.target_position = direction * 100
