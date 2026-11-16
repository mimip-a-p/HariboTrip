extends Node2D

const PLAYER_START_POS := Vector2i(15,222)
const CAM_START_POS := Vector2i(320, 180)
const CAM_LEAD : float = 320.0
const START_SPEED : float = 1
const MAX_SPEED : int = 25
const FALL_LIMIT : float = 500.0
const GAME_OVER_SCENE = preload("res://scenes/game_over.tscn")

var speed : float
var max_prog = 0
var start_pos = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	max_prog = $EndPosition.position.x - $StartPosition.position.x
	start_pos = $StartPosition.position

func new_game():
	#reset the nodes
	$Character.position = PLAYER_START_POS
	$Character.velocity = Vector2i(0, 0)
	$Camera2D.position = Vector2(CAM_LEAD, 0)
	$TileMapLayer.position = Vector2i(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Character.position.y > FALL_LIMIT:
		game_over()
		return
		
	var curr_prog = $Character.position.x - start_pos.x
	$HUD/TextureProgressBar.value = (curr_prog / max_prog) * 100
	speed = START_SPEED
	
	$Character.position.x += speed
	$Camera2D.position.x = $Character.position.x - PLAYER_START_POS.x + CAM_LEAD

func game_over() -> void:
	set_process(false)
	$Character.set_physics_process(false)
	var layer := CanvasLayer.new()
	layer.layer = 100
	add_child(layer)
	layer.add_child(GAME_OVER_SCENE.instantiate())
