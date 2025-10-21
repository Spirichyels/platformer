extends Node

@onready var PathMainMenu = "res://Elements/UI/Main_Menu/menu_title.tscn"


func _ready() -> void:
	process_mode = Node.ProcessMode.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_node(PathMainMenu).toggle_pause()
