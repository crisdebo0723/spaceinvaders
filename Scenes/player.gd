extends Area2D
class_name Player

signal player_destroyed

@export var speed = 200
var direction = Vector2.ZERO
@onready var collision_rect: CollisionShape2D = %CollisionShape2D
@onready var destroy: AnimationPlayer = $Destroy

var bounding_size_x
var start_bound
var end_bound
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bounding_size_x = collision_rect.shape.get_rect().size.x
	var rect = get_viewport().get_visible_rect()
	var camera = get_viewport().get_camera_2d()
	var camera_position = camera.position
	start_bound = (camera.position.x - rect.size.x) / 2
	end_bound = (camera.position.x + rect.size.x) / 2
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = Input.get_axis("move_left", "move_right")
	
	if input > 0:
		direction = Vector2.RIGHT
	elif input < 0: 
		direction = Vector2.LEFT
	else:
		direction = Vector2.ZERO
	
	var delta_movement = speed * delta * direction.x
	if (position.x + delta_movement < start_bound + bounding_size_x * transform.get_scale().x || position.x + delta_movement > end_bound - bounding_size_x * transform.get_scale().x):
		return
	position.x += delta_movement

func on_player_destroyed():
	speed = 0
	destroy.play("Destroy")


func _on_destroy_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Destroy":
		await get_tree().create_timer(1).timeout
		player_destroyed.emit()
		queue_free()
