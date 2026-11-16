extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.play("spin")

func _on_body_entered(body):
	if body.name == "Character":
		queue_free()
