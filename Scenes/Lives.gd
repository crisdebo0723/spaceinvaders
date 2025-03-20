extends Node

class_name LifeManager
signal life_lost(lives_left: int)

@export var lives = 3
@onready var player: Player = $"../Player"
var player_scene = preload("res://Scenes/player.tscn")

func _ready():
	(player as Player).player_destroyed.connect(on_player_destroyed)
	
func on_player_destroyed():
	lives -=1
	life_lost.emit(lives)
	if lives != 0:
		player = player_scene.instantiate() as Player
		player.global_position = Vector2(0,302)
		player.player_destroyed.connect(on_player_destroyed)
		get_tree().root.get_node("Main").add_child(player)
		
