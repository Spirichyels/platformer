extends Node3D

const BulletScene = preload("res://Elements/Enemys/SlizenRed/slizen_red.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("Level")
	SoundManager.play_level_music()
	Global.coins = 0
	pass # Replace with function body.


func _on_spawn_timeout() -> void:
	
	
	var bullet_instance = BulletScene.instantiate()
	$SlisensRed.add_child(bullet_instance)
	bullet_instance.global_position = Vector3(0,0,0).normalized()
	
	
	pass # Replace with function body.
