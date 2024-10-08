extends Area2D

@export var speed = 150

func start(pos):
	position = pos

func _process(delta):
	position.y += speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func disappearBullet():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.loseHp()
