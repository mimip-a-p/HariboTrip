extends Sprite2D

@export var CLOUD_SPEED: float = -15.0

func _ready() -> void:
	autoscroll.x = CLOUD_SPEED
