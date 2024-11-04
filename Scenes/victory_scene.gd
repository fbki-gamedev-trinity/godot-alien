extends Control


var victory_panel

func _ready() -> void:
	victory_panel = $Panel

func _process(delta: float) -> void:
	if Global.is_game_won:
		victory_panel.visible = true
		get_tree().paused = true
