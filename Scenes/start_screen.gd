extends CanvasLayer
@onready var timer: Timer = $Timer

@onready var invader_1_texture: TextureRect = %Invader1Texture
@onready var invader_1_label: Label = %Invader1Label
@onready var invader_2_texture: TextureRect = %Invader2Texture
@onready var invader_2_label: Label = %Invader2Label
@onready var invader_3_texture: TextureRect = %Invader3Texture
@onready var invader_3_label: Label = %Invader3Label
var control_array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	control_array.append_array([invader_1_texture,invader_1_label,invader_2_texture,invader_2_label,invader_3_texture,invader_3_label])
	for control in control_array:
		(control as Control).modulate = Color.TRANSPARENT
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")


func show_next_control() -> void:
	var control = control_array.pop_front() as Control
	if control != null:
		control.modulate = Color.WHITE
	else:
		timer.stop()
		timer.queue_free()
