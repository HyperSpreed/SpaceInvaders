extends Node2D

var enemiesLoaderType1 = load("res://Scenes/area_enemy_1.tscn")
var enemiesLoaderType2 = load("res://Scenes/area_enemy_2.tscn")
var enemiesLoaderType3 = load("res://Scenes/area_enemy_3.tscn")
@onready var spaceship_scene = preload("res://Scenes/mother_ship.tscn")
@export var min_interval: float = 15.0
@export var max_interval: float = 20.0
var enemies = []
var moveTimer = 1
var allEnemiesDown = false
var score = 0
var enemyIsAlive = true

@onready var respawn_timer = Timer.new()

func _ready():
	get_node("/root/Main/ScoreLabel").text = "000000"
	spawnEnemies()
	moveEnemies()
	add_child(respawn_timer)
	respawn_timer.connect("timeout", Callable(self, "_on_respawn_timer_timeout"))
	_spawn_spaceship()

func updateScore():
	var scoreStr = str(score)
	var formattedScore = scoreStr.pad_zeros(6)
	get_node("/root/Main/ScoreLabel").text = str(formattedScore)
	print(formattedScore)

func moveEnemies():
	while allEnemiesDown == false:
		for i in range(11):
			await get_tree().create_timer(moveTimer).timeout
			move_enemies_right()
		await get_tree().create_timer(moveTimer).timeout
		move_enemies_down()
		for i in range(11):
			await get_tree().create_timer(moveTimer).timeout
			move_enemies_left()
		await get_tree().create_timer(moveTimer).timeout
		move_enemies_down()

func spawnEnemies():
	var Xposition = 40
	for i in range(8):
		var enemy_instanceUp = enemiesLoaderType1.instantiate()
		enemy_instanceUp.position = Vector2(Xposition, 100)
		self.add_child(enemy_instanceUp)
		var enemy_instanceDown = enemiesLoaderType1.instantiate()
		enemy_instanceDown.position = Vector2(Xposition, 150)
		self.add_child(enemy_instanceDown)
		enemies.append(enemy_instanceUp)
		enemies.append(enemy_instanceDown)
		#CHANGE ENEMY TYPE
		var enemy_instanceUp2 = enemiesLoaderType2.instantiate()
		enemy_instanceUp2.position = Vector2(Xposition, 200)
		self.add_child(enemy_instanceUp2)
		var enemy_instanceDown2 = enemiesLoaderType2.instantiate()
		enemy_instanceDown2.position = Vector2(Xposition, 250)
		self.add_child(enemy_instanceDown2)
		enemies.append(enemy_instanceUp2)
		enemies.append(enemy_instanceDown2)
		#CHANGE ENEMY TYPE
		var enemy_instanceUp3 = enemiesLoaderType3.instantiate()
		enemy_instanceUp3.position = Vector2(Xposition, 300)
		self.add_child(enemy_instanceUp3)
		var enemy_instanceDown3 = enemiesLoaderType3.instantiate()
		enemy_instanceDown3.position = Vector2(Xposition, 350)
		self.add_child(enemy_instanceDown3)
		enemies.append(enemy_instanceUp3)
		enemies.append(enemy_instanceDown3)
		Xposition += 50

func move_enemies_right():
		for enemy in enemies:
			#if enemyIsAlive == true:
				enemy.position.x += 20

func move_enemies_left():
	for enemy in enemies:
		enemy.position.x -= 20
		
func move_enemies_down():
	for enemy in enemies:
		enemy.position.y += 50

func _on_enemy_died(value):
	score += value

func _spawn_spaceship():
	var spaceship = spaceship_scene.instantiate()
	var start_positions = [Vector2(36, 56), Vector2(600, 56)]
	spaceship.position = start_positions[randi() % start_positions.size()]
	
	add_child(spaceship)
	spaceship.connect("tree_exited", Callable(self, "_on_spaceship_removed"))
	
	respawn_timer.wait_time = randf_range(min_interval, max_interval)
	respawn_timer.start()

func _on_spaceship_removed():
	respawn_timer.start()

func _on_respawn_timer_timeout() -> void:
	_spawn_spaceship()
