extends Node2D

const PLAYER_START_POS := Vector2i(15,222)
const CAM_START_POS := Vector2i(320, 180)

var speed : float
const START_SPEED : float = 1
const MAX_SPEED : int = 25


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func new_game():
	#reset the nodes
	$Character.position = PLAYER_START_POS
	$Character.velocity = Vector2i(0, 0)
	$Camera2D.position = Vector2i(0, 0)
	$TileMapLayer.position = Vector2i(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speed = START_SPEED
	
	#move player and camera
	$Character.position.x += speed
	$Camera2D.position.x += speed
