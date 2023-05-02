extends Control


@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("sway")

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://levels/test_level.tscn")


func _on_quit_button_toggled(button_pressed):
	get_tree().quit()
