extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 12

var xform : Transform3D 

@onready var camera = $Camera_Controller
var mouse_sensitivity: float = 0.2
var camera_pitch: float = 0.0

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion:
		## Горизонталь — вращаем тело игрока
		#camera.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		## Вертикаль — вращаем только камеру (ограничиваем угол)
		
		
		#

var sensitivity: float = 0.2

func _ready() -> void:
	
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		camera.rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		camera_pitch = clamp(camera_pitch - event.relative.y * mouse_sensitivity, -80, 80)
		camera.rotation_degrees.x = camera_pitch
	
		
		pass
		




		
func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("player_a", "player_d", "player_w", "player_s")
	
	#Воспроизводить анимацию робота 
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$AnimationPlayer.play("jump")
	elif is_on_floor() and input_dir != Vector2.ZERO:
		$AnimationPlayer.play("run")
	elif is_on_floor() and input_dir == Vector2.ZERO:
		$AnimationPlayer.play("idle")
		
	
	#Камера поварачивается в лево / в право
	if Input.is_action_pressed("cam_left"):
		$Camera_Controller.rotate_y(deg_to_rad(5))
	if Input.is_action_pressed("cam_right"):
		$Camera_Controller.rotate_y(deg_to_rad(-5))
	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$AudioJump.play()
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.

	
	# New Vector3 направление, зависит от поворота камеры
	var direction: Vector3 = ($Camera_Controller.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	#Повернуть сетку персонажа в направления движения относительно камере
	if input_dir != Vector2(0,0):
		$Armature.rotation_degrees.y = $Camera_Controller.rotation_degrees.y-rad_to_deg(input_dir.angle())-90
	
	#Повернуть персонажа чтобы он оказался на полу
	
	
	if is_on_floor() and input_dir!=Vector2(0,0):
		align_with_floor($RayCast3D.get_collision_normal())
		global_transform = global_transform.interpolate_with(xform, 0.3)
	elif not is_on_floor():
		align_with_floor(Vector3.UP)
		global_transform = global_transform.interpolate_with(xform, 0.3)
	
	#Обновление скорости и движения персонажа
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)


	move_and_slide()
	
	#Make Camera Controller match the position of player
	$Camera_Controller.position = lerp($Camera_Controller.position, position, 0.15)
	
	#print("camera" ,$Camera_Controller.rotation_degrees.y)
	#print("player" ,$MeshInstance3D.rotation_degrees.y)
	
func align_with_floor(floor_normal):
	xform = global_transform
	xform.basis.y = floor_normal
	xform.basis.x = -xform.basis.z.cross(floor_normal)
	xform.basis = xform.basis.orthonormalized()

func bounce():
	velocity.y = JUMP_VELOCITY * 0.7

func _on_fall_zone_body_entered(body: Node3D) -> void:
	SoundManager.play_fall_sound()
	get_tree().change_scene_to_file("res://Scene/menu_game_over.tscn")
	#get_tree().reload_current_scene()
	pass # Replace with function body.
