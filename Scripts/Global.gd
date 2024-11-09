extends Node

var player_lives

func _ready():
	player_lives = 3

var is_game_won = false

signal lives_updated

signal keys_updated
var collected_keys = {}

func handle_victory():
	is_game_won = true
