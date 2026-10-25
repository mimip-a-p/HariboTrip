extends CharacterBody2D

const GRAVITY : int = 4200
const JUMP_SPEED : int = -900
const FILLED_GEM = preload("res://assets/img/collect/SiborgGem.png")

var score_counter = 0
var gems_collected: int = 0
var gem_list: Array[TextureRect] = []

@onready var score_label = %Label
@onready var gem_bar = %gem_bar

func _ready() -> void:
	for child in gem_bar.get_children():
		if child is TextureRect:
			gem_list.append(child)
			
	print("Gem slots found: ", gem_list.size())

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_SPEED
			
	move_and_slide()

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
	
