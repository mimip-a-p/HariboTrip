extends Node

const FILLED_GEM = preload("res://assets/img/collect/SiborgGem.png")

var score_counter = 0
var gems_collected: int = 0
var gem_list: Array[TextureRect] = []

@onready var score_label = get_tree().current_scene.get_node("%Label")
@onready var gem_bar = %gem_bar

func _ready() -> void:
	for child in gem_bar.get_children():
		if child is TextureRect:
			gem_list.append(child)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Piso"):
		set_score(score_counter + 1 * 10)
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
