extends CharacterBody2D

var speed = 100  # Скорость движения врага
var move_distance = 50  # Максимальное расстояние от точки спавна
var direction = 1  # Направление движения (1 - вправо, -1 - влево)
var spawn_position = Vector2()  # Позиция спавна врага
var animated_sprite

func _ready():
	# Сохраняем позицию спавна
	spawn_position = position
	animated_sprite = $AnimatedSprite2D 
	add_to_group("enemy")

func _process(delta):
	# Двигаем врага
	position.x += speed * direction * delta

	# Проверяем границы движения
	if position.x > spawn_position.x + move_distance:
		direction = -1  # Меняем направление на влево
	elif position.x < spawn_position.x - move_distance:
		direction = 1  # Меняем направление на вправо
		
	animated_sprite.flip_h = direction > 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.velocity.y > 0:
		animated_sprite.play("death")
		await animated_sprite.animation_finished
		queue_free()
	else: 
		body.die()
