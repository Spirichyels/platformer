extends CanvasLayer


func _ready() -> void:
	process_mode = Node.ProcessMode.PROCESS_MODE_ALWAYS
	visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()
		
func toggle_pause() -> void:
	if get_tree().paused:
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		visible = false
	else:	
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		visible = true

func _on_button_pressed() -> void:
	toggle_pause()
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	toggle_pause()
	get_tree().change_scene_to_file("res://Scene/menu_title.tscn")
	pass # Replace with function body.
