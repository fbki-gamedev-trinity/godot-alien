extends Area2D

const SPEED = 20
var direction = 1 
var start_position: Vector2
var end_position: Vector2
const MOVE_DISTANCE = 50.0
var animated_sprite

func _ready() -> void:
	start_position = position
	animated_sprite = $AnimatedSprite2D
	add_to_group("enemies")
	

func _on_body_entered(body: Node2D) -> void:
	var my_position = global_position
	var other_position = body.global_position

	# Вычисляем разницу между позициями
	var direction = other_position - my_position

	# Определяем сторону столкновения
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			print("Столкновение справа")
		else:
			print("Столкновение слева")
	else:
		if direction.y > 0:
			print("Столкновение снизу")
		else:
			print("Столкновение сверху")
			animated_sprite.play("dead")
