extends Area2D

signal died
var value = 100
var typeEnemy = 3
@onready var bullet_scene = preload("res://Scenes/enemy_bullet.tscn")
var isAlive = true

func _ready():
	if isAlive == true:
		$ShootTimer.wait_time = randf_range(15, 52)
		$ShootTimer.start()

func explode():
	var scoreEachEnemy = get_node("/root/Main")
	scoreEachEnemy.score += value
	get_node("/root/Main").updateScore()
	#$AnimationPlayer.play("explode")      #USE THIS TO PLAY AN EXPLODING ANIMATION
	set_deferred("monitorable",false)
	died.emit(5)
	#await $AnimationPlayer.animation_finished       #USE THIS TO PLAY AFTER THE END OF ANIMATION
	hide()
	isAlive = false
	$ShootTimer.stop()
	#queue_free()

func dropBullets():
	var playerPosition = $".".position
	var bulletYPosition = playerPosition.y + 10
	$ShootTimer.wait_time = randf_range(15, 52)
	$ShootTimer.start()
	var bulletShots = bullet_scene.instantiate()
	bulletShots.position = Vector2(playerPosition, bulletYPosition)
	add_child(bulletShots)

func enemyShoot_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.position = position + Vector2(0,-10)
	get_tree().root.add_child(bullet)
	$ShootTimer.wait_time = randf_range(15, 52)
	$ShootTimer.start()
	#canShoot = false

func _on_shoot_timer_timeout():
	if not isAlive:
		return
	$ShootTimer.wait_time = randf_range(15, 52)
	enemyShoot_bullet()
