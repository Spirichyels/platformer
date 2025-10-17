extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("Level")
	SoundManager.play_level_music()
	Global.coins = 0
	pass # Replace with function body.
