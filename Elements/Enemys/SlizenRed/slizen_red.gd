extends CharacterBody3D

@export var PathGameOver = "res://Elements/Menu/Game_Over/menu_game_over.tscn"

var speed = 2.0
@export var direction:=Vector3(0,0,0)
@export var turns_around_at_edges := true
@onready var player = get_tree().get_current_scene().get_node("Player")
var turning := false

func _physics_process(delta: float) -> void:
	direction = (player.global_transform.origin - global_transform.origin)
	direction.y = 0  # <-- обнуляем вертикаль, чтобы не смотрел вверх/вниз
	direction = direction.normalized()
	if turning:
		direction = -direction
	look_at(global_transform.origin+ direction, Vector3.UP)
	
	print(direction)
	print(-direction)
	
	velocity.x = speed * direction.x
	velocity.z = speed * direction.z
	
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()
	
	if is_on_wall() and not turning:
		turn_around()
	if not $RayCast3D.is_colliding() and is_on_floor() and not turning and turns_around_at_edges:
		turn_around()


func turn_around():
	turning = true
	var dir = direction
	direction = Vector3.ZERO
	var turn_tween = create_tween()
	turn_tween.tween_property(self, "rotation_degrees",Vector3(0,180,0),0.6).as_relative()
	await get_tree().create_timer(2).timeout
	
	
	direction.x=dir.x * -1
	direction.z = dir.z * -1
	turn_tween = create_tween()
	turn_tween.tween_property(self, "rotation_degrees",Vector3(0,180,0),0.6).as_relative()
	
	turning = false


func _on_sides_checker_2_body_entered(_body: Node3D) -> void:
	SoundManager.play_enemy_sound()
	if Global.DEBUG:
		get_tree().reload_current_scene()
		pass
	else :
		get_tree().change_scene_to_file(PathGameOver)
	
	pass # Replace with function body.

func _on_top_checker_body_entered(body: Node3D) -> void:
	$AnimationPlayer.play("squash")
	$AudioSquash.play()
	body.bounce()
	$SidesChecker2.set_collision_mask_value(1, false)
	$TopChecker.set_collision_mask_value(1, false)
	
	direction = Vector3.ZERO
	speed = 0
	await get_tree().create_timer(0.3).timeout
	queue_free()
	pass # Replace with function body.
