extends Control

@export var PathLevels = "res://Elements/Levels/Level1/level_1.tscn"


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	#print("Menu")
	pass

func _on_button_pressed() -> void:
	load_level()
	
	pass # Replace with function body.

func load_level():
	SoundManager.play_button_sound()
	get_tree().change_scene_to_file(PathLevels)
	SoundManager.stop_menu_music()
	
