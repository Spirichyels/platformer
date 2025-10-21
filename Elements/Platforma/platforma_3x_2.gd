extends AnimatableBody3D


@export var a:=Vector3()
@export var b:=Vector3()
@export var time:float = 2.0
@export var pause:float = 1.0

func _ready() -> void:
	move()
	
func move2():
	var move_tween = create_tween()
	move_tween.tween_property(self, "position", b, time).set_trans(Tween.TRANS_SINE).set_delay(pause)
	move_tween.tween_property(self, "position", a, time).set_trans(Tween.TRANS_SINE).set_delay(pause)
	await get_tree().create_timer(2*time+2*pause).timeout
	move2()
	
	
func move():
	
	while(true):
		var move_tween = create_tween()
		move_tween.tween_property(self, "position", b, time).set_trans(Tween.TRANS_SINE).set_delay(pause)
		move_tween.tween_property(self, "position", a, time).set_trans(Tween.TRANS_SINE).set_delay(pause)
		await move_tween.finished
		
	
	
	
