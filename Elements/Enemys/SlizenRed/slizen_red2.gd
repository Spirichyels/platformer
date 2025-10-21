extends CharacterBody3D

var speed = 5.0
@export var direction:=Vector3(0,0,0)
@onready var player = get_tree().get_current_scene().get_node("Player")
@export var turns_around_at_edges := true
@onready var turning := false




var koeff = 1

var retreat_dir = Vector3.ZERO
var retreat_time = 0.0



func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if turning:
		# Пока отступает — идёт в противоположную сторону
		if retreat_time > 0:
			velocity.x = speed * retreat_dir.x
			velocity.z = speed * retreat_dir.z
			retreat_time -= delta
		else:
			turning = false
	else:
		if is_on_wall():
			turn_around()
		else:
			move_no_fall()

	move_and_slide()
		
		
func move_no_fall():
	
	direction = (player.global_transform.origin - global_transform.origin)
	direction.y = 0
	direction = direction.normalized()
	look_at(global_transform.origin + direction, Vector3.UP)

	velocity.x = speed * direction.x
	velocity.z = speed * direction.z
	

	
	
	
func turn_around():
	
	if turning:
		return
	turning = true

	# Остановка
	velocity = Vector3.ZERO

	# Рассчёт направления от игрока
	var to_player = (player.global_transform.origin - global_transform.origin)
	to_player.y = 0
	to_player = to_player.normalized()
	retreat_dir = -to_player

	# Поворот на 180°
	var target_rot = atan2(retreat_dir.x, retreat_dir.z)
	var turn_tween = create_tween()
	turn_tween.tween_property(self, "rotation:y", target_rot, 0.5)
	
	# После поворота — движение в обратную сторону 2 секунды
	await get_tree().create_timer(0.5).timeout
	retreat_time = 2.0
	
	
	

	
	
	
	
func _on_sides_checker_body_entered(body: Node3D) -> void:
	SoundManager.play_enemy_sound()
	get_tree().change_scene_to_file("res://Scene/menu_game_over.tscn")
	
	pass # Replace with function body.
	
func _on_top_checker_body_entered(body: Node3D) -> void:
	
	$AnimationPlayer.play("squash")
	$AudioSquash.play()
	body.bounce()
	$SidesChecker.set_collision_mask_value(1, false)
	$TopChecker.set_collision_mask_value(1, false)
	
	direction = Vector3.ZERO
	speed = 0
	await get_tree().create_timer(0.3).timeout
	queue_free()
	
	pass # Replace with function body.
