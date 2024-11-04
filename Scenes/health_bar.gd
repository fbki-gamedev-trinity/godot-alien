extends Control

var heart_container 

func _ready():
	Global.lives_updated.connect(update_lives_display)
	heart_container = $HBoxContainer
	update_lives_display()

func update_lives_display():
	# Удаляем все сердечки из контейнера
	for child in heart_container.get_children():
		child.queue_free()

	# Добавляем сердечки в зависимости от количества жизней
	for i in range(Global.player_lives):
		var heart = TextureRect.new()
		heart.texture = preload("res://Assets/hud_heartFull.png")  # Путь к полному сердечку
		heart_container.add_child(heart)

	# Если хотите добавить пустые сердечки для максимального количества жизней
	var max_lives = 3  # Максимальное количество жизней
	for i in range(Global.player_lives, max_lives):
		var empty_heart = TextureRect.new()
		empty_heart.texture = preload("res://Assets/hud_heartEmpty.png")  # Путь к пустому сердечку
		heart_container.add_child(empty_heart)
