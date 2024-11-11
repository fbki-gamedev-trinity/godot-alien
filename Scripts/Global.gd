extends Node

var player_lives

func _ready():
	player_lives = 3

var is_game_won = false
var is_game_over = false

signal lives_updated

signal keys_updated
var collected_keys = []
	
func reset_game():
	player_lives = 3
	is_game_over = false
	is_game_won = false
	collected_keys.clear()
	emit_signal("lives_updated")
	emit_signal("keys_updated")
