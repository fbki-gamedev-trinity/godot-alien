extends Area2D


func _ready() -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.is_game_won = true
		var node_game_over = $"../CanvasLayer/Control"
		node_game_over.game_over()
		queue_free()
