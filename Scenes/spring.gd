extends Area2D


var is_bouncing = false
const BOUNCE_FORCE = -850.0
const BOUNCE_DURATION = 0.5

var animated_sprite
var spring_sound

func _ready():
	animated_sprite = $AnimatedSprite2D
	spring_sound = $SpringSound
	animated_sprite.play("idle")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not is_bouncing:
		is_bouncing = true
		animated_sprite.play("bounce")
		spring_sound.play()
		body.velocity.y = BOUNCE_FORCE

		await get_tree().create_timer(0.5).timeout
		
		animated_sprite.play("idle")
		is_bouncing = false
