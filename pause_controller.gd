extends Node


func _ready() -> void:
	process_mode = Node.ProcessMode.ALWAYS

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_node("/root/PauseMenu").toggle_pause()
