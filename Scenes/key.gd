extends Area2D

@export var color: String

func _ready():
	var sprite = $Sprite2D
	var path = "res://Assets/Keys_And_Locks/key_" + color + ".png"
	sprite.texture = load(path)
			

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.collect_key(self)
		queue_free()
