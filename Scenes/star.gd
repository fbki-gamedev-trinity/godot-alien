extends Area2D


func _ready() -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.handle_victory()
		queue_free()
