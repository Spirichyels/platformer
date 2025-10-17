extends Control

func _ready() -> void:
	play_menu_music()

func play_enemy_sound():
	$SoundEnemy.play()
	
func play_coin_sound():
	$SoundCoin.play()
	pass
	
func play_fall_sound():
	$SoundFall.play()
	pass
	
func play_button_sound():
	$SoundButton.play()
	pass
	
func play_menu_music():
	$MusicLevel.stop()
	$MusicMenu.play()
	
func stop_menu_music():
	$MusicMenu.stop()
	
func play_level_music():
	$MusicLevel.play()
	
func stop_level_music():
	$MusicLevel.stop()
