extends Control

var heart_container 
var key_container

func _ready():
	Global.lives_updated.connect(update_lives_display)
	Global.keys_updated.connect(update_key_display)
	heart_container = $VBoxContainer/HBoxContainer
	key_container = $VBoxContainer/Keys
	update_lives_display()
	update_key_display(Global.collected_keys)

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

func update_key_display(collected_keys: Dictionary) -> void:
	for child in key_container.get_children():
		child.queue_free()

	for color in collected_keys.keys():
		var count = collected_keys[color]
		for i in range(count):
			var key_icon = TextureRect.new()
			var path = "res://Assets/Keys_And_Locks/key_" + color + ".png"
			key_icon.texture = load(path)
			key_container.add_child(key_icon)
