extends Control


var victory_panel
var message_label

func _ready() -> void:
	victory_panel = $Panel
	message_label = $Panel/VBoxContainer/Label
	

func game_over() -> void:
	victory_panel.visible = true
	get_tree().paused = true
	if Global.is_game_won:
		message_label.text = "Победа!"
	else:
		message_label.text = "Вы проиграли!"
	
func _on_button_pressed() -> void:
	Global.reset_game()
	get_tree().paused = false
	get_tree().reload_current_scene()
