extends Area2D

@export var color: String

func _ready():
	var sprite = $Sprite2D
	var path = "res://Assets/Keys_And_Locks/lock_" + color + ".png"
	sprite.texture = load(path)
			

func _on_body_entered(body: Node2D) -> void:
	print_debug('lock')
	if body.is_in_group("player"):
		body.try_open_door(self)
