extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D

var hit := false

func _ready() -> void:
	animated_sprite_2d.play("idle")

func _on_body_entered(body):
	if body.name == "Character" and not hit:
		hit = true
		animated_sprite_2d.play("broken")
		get_tree().call_group("main", "game_over")
