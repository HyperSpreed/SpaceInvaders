extends Area2D

var speed = 400

func _physics_process(delta):
	position.y -= speed*delta
	if position.y<0:
		queue_free()
	
