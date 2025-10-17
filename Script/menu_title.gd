extends Control


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#print("Menu")
	pass

func _on_button_pressed() -> void:
	
	SoundManager.play_button_sound()
	ResourceLoader.load("res://Assets/Textures/world-block-v1.tres", "", 1)
	get_tree().change_scene_to_file("res://Scene/level_1.tscn")
	SoundManager.stop_menu_music()
	pass # Replace with function body.
