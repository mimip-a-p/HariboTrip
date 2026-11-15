extends CharacterBody2D

const GRAVITY : int = 3600
const SPEED : float = 300.0
const JUMP_SPEED : int = -900
const SLOPE_THRESHOLD : float = 0.1
const AIR_GRACE : float = 0.15
const STATE_DELAY : float = 0.1
const FILLED_GEM = preload("res://assets/img/collect/SiborgGem.png")

var air_time := 0.0
var ground_state := "run"
var state_time := 0.0
var score_counter = 0
var gems_collected: int = 0
var gem_list: Array[TextureRect] = []

@onready var collision_run = $RunCollision
@onready var collision_up = $UpCollision
@onready var collision_down = $DownCollision
@onready var score_label = %Label
@onready var gem_bar = %gem_bar

func _ready() -> void:
	floor_snap_length = 16.0
	floor_constant_speed = true
	_apply_state()
	for child in gem_bar.get_children():
		if child is TextureRect:
			gem_list.append(child)
			
	print("Gem slots found: ", gem_list.size())

func _physics_process(delta):
	velocity.y += GRAVITY * delta

	if is_on_floor():
		air_time = 0.0
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_SPEED
	else:
		air_time += delta

	move_and_slide()
	_update_animation(delta)
	
func _update_animation(delta: float) -> void:
	if air_time > AIR_GRACE:
		$PlayerRun.stop()   # jump animation goes here
		return

	var wanted := ground_state
	if is_on_floor():
		var n := get_floor_normal()
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
		$PlayerRun.play(ground_state)

func _apply_state() -> void:
	$PlayerRun.play(ground_state)
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

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Piso"):
		set_score(score_counter + 1 * 10)
		print(score_counter)
		
	elif area.is_in_group("Gem"):
		add_gem_to_bar()
		area.queue_free()	
	
func set_score(new_score_count: int) -> void:
	score_counter = new_score_count
	score_label.text = "Score: " + str(score_counter)

func add_gem_to_bar() -> void:
	if gems_collected >= gem_list.size():
		return

	gem_list[gems_collected].texture = FILLED_GEM
	gems_collected += 1
	
	print("Gems collected: ", gems_collected)
