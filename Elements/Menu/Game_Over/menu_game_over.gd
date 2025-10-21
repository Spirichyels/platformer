extends Control

@export var PathMainMenu2 = "res://Elements/Menu/Main_Menu/menu_main.tscn"

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	SoundManager.play_menu_music()


func _on_button_pressed() -> void:
	SoundManager.play_button_sound()
	print("gameOveButton")
	print(PathMainMenu2)
	get_tree().change_scene_to_file(PathMainMenu2)
	pass # Replace with function body.
