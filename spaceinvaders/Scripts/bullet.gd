extends Area2D

@export var speed = -250

func start(pos):
	position = pos

func _process(delta):
	position.y += speed * delta

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		area.explode()
		queue_free()
	if area.is_in_group("Bullets"):
		area.disappearBullet()
		queue_free()
	if area.is_in_group("spaceShip"):
		area._on_spaceship_exiting()
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
