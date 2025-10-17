extends Control

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	SoundManager.play_menu_music()


func _on_button_pressed() -> void:
	SoundManager.play_button_sound()
	get_tree().change_scene_to_file("res://Scene/menu_title.tscn")
	pass # Replace with function body.
