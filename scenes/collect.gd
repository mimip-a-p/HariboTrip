extends Node

const FILLED_GEM = preload("res://assets/img/collect/SiborgGem.png")
const POINTS_PER_SECOND : float = 10.0

var score_counter = 0
var score_progress : float = 0.0
var gems_collected: int = 0
var gem_list: Array[TextureRect] = []
var last_x : float = 0.0

@onready var score_label = get_tree().current_scene.get_node("%Label")
@onready var gem_bar = %gem_bar
@onready var player : CharacterBody2D = get_parent()

func _ready() -> void:
	last_x = player.position.x
	for child in gem_bar.get_children():
		if child is TextureRect:
			gem_list.append(child)

func _process(delta: float) -> void:
	if not player.is_physics_processing():
		return			

	var moved : bool = player.position.x > last_x
	last_x = player.position.x

	if moved:
		score_progress += POINTS_PER_SECOND * delta
		var new_score := int(score_progress)
		if new_score != score_counter:
			set_score(new_score)
			
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Piso"):
		score_progress += 10.0
		set_score(int(score_progress))
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
