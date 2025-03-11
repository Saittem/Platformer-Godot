extends Control

@onready var playBtn = $buttons/playButton

func _ready():
	playBtn.add_theme_color_override("font_hover_color", Color("#000000"))

func _on_play_pressed():
	get_tree().change_scene_to_file("res://assets/scenes/game.tscn")
