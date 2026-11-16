extends Node

const SLOPE_THRESHOLD : float = 0.1
const AIR_GRACE : float = 0.15
const STATE_DELAY : float = 0.1

var ground_state := "run"
var state_time := 0.0

@onready var player: CharacterBody2D = get_parent()
@onready var sprite = player.get_node("Kalesa")
@onready var collision_run = player.get_node("RunCollision")
@onready var collision_up = player.get_node("UpCollision")
@onready var collision_down = player.get_node("DownCollision")

func _ready() -> void:
	_apply_state()

func update_animation(delta: float) -> void:
	if player.air_time > AIR_GRACE:
		sprite.stop()
		return

	var wanted := ground_state
	if player.is_on_floor():
		var n := player.get_floor_normal()
		if n.x < -SLOPE_THRESHOLD:
			wanted = "upward"
		elif n.x > SLOPE_THRESHOLD:
			wanted = "downward"
		else:
			wanted = "run"

	if wanted != ground_state:
		state_time += delta
		if state_time >= STATE_DELAY:
			ground_state = wanted
			state_time = 0.0
			_apply_state()
	else:
		state_time = 0.0
		sprite.play(ground_state)

func _apply_state() -> void:
	sprite.play(ground_state)
	match ground_state:
		"upward":
			_set_collision(collision_up)
		"downward":
			_set_collision(collision_down)
		_:
			_set_collision(collision_run)

func _set_collision(active: CollisionShape2D) -> void:
	for shape in [collision_run, collision_up, collision_down]:
		shape.set_deferred("disabled", shape != active)
