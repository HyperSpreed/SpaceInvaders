extends CharacterBody2D

var speed = 4
var canShoot = true
var shootCooldown = 0.5
var time_since_last_shoot = 0.0
@onready var bullet_scene = preload("res://Scenes/bullet.tscn")
var hp = 3

func _ready():
	get_node("/root/Main/HpLabel").text = "Lives: " + str(hp)

func loseHp():
	if hp <= 1:
		hp -= 1
		queue_free()
		get_node("/root/Main/HpLabel").text = "Lives: " + str(hp)
	elif hp>0:
		hp -= 1
		print(hp)
		get_node("/root/Main/HpLabel").text = "Lives: " + str(hp)

func _process(delta):
	if not canShoot:
		time_since_last_shoot += delta
		if time_since_last_shoot >= shootCooldown:
			canShoot = true
			time_since_last_shoot = 0.0
	
	if Input.is_action_pressed("ui_accept") and canShoot:
		shoot_bullet()

func _physics_process(delta):
	var velocityPlayer = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		velocityPlayer.x -= 1
	if Input.is_action_pressed("move_right"):
		velocityPlayer.x += 1
	move_and_collide(velocityPlayer*speed)

func shoot_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.position = position + Vector2(0,-10)
	get_parent().add_child(bullet)
	canShoot = false
