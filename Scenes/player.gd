extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DAMAGE_PUSH_BACK_FORCE = 200.0

var animated_sprite
var is_hurt = false
var jump_sound
var hurt_sound

var collected_keys = []

func _ready():
	animated_sprite = $AnimatedSprite2D
	jump_sound = $Node2D/JumpSound
	hurt_sound = $Node2D/HurtSound
	animated_sprite.play("idle")
	add_to_group("player")

func _physics_process(delta: float) -> void:
	# Применяем гравитацию, если не на полу
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not is_hurt:
		velocity.y = JUMP_VELOCITY
		jump_sound.play()
		animated_sprite.play("jump")

	# Получаем направление движения
	var direction := Input.get_axis("ui_left", "ui_right")
	
	# Обработка движения
	if direction and not is_hurt:
		velocity.x = direction * SPEED
		
		# Поворот спрайта в зависимости от направления
		if direction > 0:
			animated_sprite.flip_h = false  # Поворачиваем вправо
			if is_on_floor():
				animated_sprite.play("walk")  # Запускаем анимацию бега
		else:
			animated_sprite.flip_h = true   # Поворачиваем влево
			if is_on_floor():
				animated_sprite.play("walk")  # Запускаем анимацию бега
	else:
		if not is_hurt:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if is_on_floor():
				animated_sprite.play("idle")  # Запускаем анимацию ожидания, если на полу

	# Если не на полу, анимация прыжка будет активна
	if not is_on_floor() and animated_sprite.animation != "jump":
		animated_sprite.play("jump")

	# Двигаем игрока
	move_and_slide()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	print_debug(body)
	if body.is_in_group("spikes") or body.is_in_group("enemy"):
		die()

func die():
	if not is_hurt:
		is_hurt = true
		if(Global.player_lives == 0):
			var node_game_over = $"../CanvasLayer/Control"
			node_game_over.game_over()
		else:
			Global.player_lives -= 1
			hurt_sound.play()
			Global.emit_signal("lives_updated")
			
			velocity.x = 0
			velocity.x = -DAMAGE_PUSH_BACK_FORCE * (-1 if animated_sprite.flip_h else 1)
			animated_sprite.play("hurt")
			
			await get_tree().create_timer(0.5).timeout
			
			is_hurt = false

func collect_key(key: Node2D) -> void:
	var key_color = key.color
	Global.collected_keys.append(key_color)
	Global.emit_signal("keys_updated", Global.collected_keys)

func try_open_door(lock: Node2D) -> void:
	var lock_color = lock.color
	print_debug(lock_color, collected_keys, lock_color in collected_keys)
	if lock_color in Global.collected_keys:
		Global.collected_keys.erase(lock_color)
		lock.queue_free()
		Global.emit_signal("keys_updated", Global.collected_keys)
