extends CanvasLayer

var life_texture = preload("res://Assets/Player/Player.png")

@onready var lives_ui_container: HBoxContainer = $MarginContainer/HBoxContainer
@onready var points_label: Label = $MarginContainer/Points
@onready var game_over_container: CenterContainer = $MarginContainer/GameOverContainer
@onready var game_over_label: Label = %GameOverLabel
@onready var game_over_button: Button = %GameOverButton

@onready var points_counter = $"../PointsCounter" as PointsCounter
@onready var life_manager = $"../LifeManager" as LifeManager
@onready var invader_spawner = $"../InvaderSpawner" as InvaderSpawner

func _ready():
	points_label.text = "SCORE: %d" % 0
	points_counter.on_points_increased.connect(points_increased)
	invader_spawner.game_lost.connect(on_game_lost)
	invader_spawner.game_won.connect(on_game_won)
	game_over_button.pressed.connect(on_restart_button_pressed)
	life_manager.life_lost.connect(on_life_lost)
	
	for i in range(life_manager.lives):
		var life_texture_rect = TextureRect.new()
		life_texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		life_texture_rect.custom_minimum_size = Vector2(40,25)
		life_texture_rect.texture = life_texture
		lives_ui_container.add_child(life_texture_rect)
		
func points_increased(points: int):
	points_label.text = "SCORE: %d" % points
	
func on_game_lost():
	game_over_container.visible = true
	
func on_game_won():
	game_over_label.text = "You won!"
	game_over_label.add_theme_color_override("font_color", Color.GREEN)
	game_over_container.visible = true

func on_restart_button_pressed():
	get_tree().reload_current_scene()
	
func on_life_lost(lives_left):
	if lives_left != 0:
		var life_texture_rect = lives_ui_container.get_child(lives_left)
		life_texture_rect.queue_free()
	else:
		on_game_lost()
	
