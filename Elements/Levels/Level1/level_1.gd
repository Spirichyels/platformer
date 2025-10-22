extends Node3D

const BulletScene = preload("res://Elements/Enemys/SlizenRed/slizen_red.tscn")
const GAME_OVER_SCENE = preload("res://Elements/Menu/Game_Over/menu_game_over.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("Level")
	SoundManager.play_level_music()
	Global.coins = 0
	Global.reset()
	Events.lives_changed.connect(func(lives): check_game_over())
	pass # Replace with function body.

func check_game_over():
	var enemies = get_tree().get_nodes_in_group("enemy")
	if Global.lives <= 0:
		add_child(GAME_OVER_SCENE.instantiate())

func _on_spawn_timeout() -> void:
	
	
	var bullet_instance = BulletScene.instantiate()
	$SlisensRed.add_child(bullet_instance)
	bullet_instance.global_position = Vector3(0,0,0).normalized()
	
	
	pass # Replace with function body.
