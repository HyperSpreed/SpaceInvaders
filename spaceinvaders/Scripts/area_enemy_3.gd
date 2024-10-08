extends Area2D

signal died
var value = 100
var typeEnemy = 3

func explode():
	#$AnimationPlayer.play("explode")      #USE THIS TO PLAY AN EXPLODING ANIMATION
	set_deferred("monitorable",false)
	died.emit(5)
	#await $AnimationPlayer.animation_finished       #USE THIS TO PLAY AFTER THE END OF ANIMATION
	hide()
	#queue_free()

func start():
	$ShootTimer.wait_time = randf_range(4, 20)
	$ShootTimer.start()

func _on_shoot_timer_timeout():
	$ShootTimer.wait_time = randf_range(4, 20)
	$ShootTimer.start()
