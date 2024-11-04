extends Node

var player_lives

func _ready():
	print_debug('_ready')
	player_lives = 3

var is_game_won = false

signal lives_updated

func handle_victory():
	is_game_won = true
