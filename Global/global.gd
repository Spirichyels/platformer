extends Node

@export var default_lives :=3

const NUM_COINS_TO_WIN = 13
const DEBUG = false


var lives = default_lives

var coins := 0


func reset():
	lives =default_lives
	Events.lives_changed.emit(lives)
	
func change_lives(diff: int):
	lives += diff
	Events.lives_changed.emit(lives)
