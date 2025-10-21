extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CoinsLabel.text = str(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$FPS.text = 'FPS: %s' % Engine.get_frames_per_second()
	#$CoinsLabel.text = str(Global.coins)
	pass
