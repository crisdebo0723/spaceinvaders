extends Node2D
@onready var spawn_timer: Timer = $SpawnTimer
@export var ufo_scene: PackedScene = preload("res://Scenes/ufo.tscn")
func _ready():
	(spawn_timer as SpawnTimer).setup_timer()
	


func _on_spawn_timer_timeout():
	var ufo = ufo_scene.instantiate()
	ufo.global_position = position
	get_tree().root.add_child(ufo)
	
	
