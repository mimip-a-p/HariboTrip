extends TextureProgressBar

func _process(delta: float) -> void:
	$Siborg.position.x = value * size.x / 100 - 20
