extends Node2D

var enemiesLoaderType1 = load("res://Scenes/area_enemy_1.tscn")
var enemiesLoaderType2 = load("res://Scenes/area_enemy_2.tscn")
var enemiesLoaderType3 = load("res://Scenes/area_enemy_3.tscn")
var enemies = []
var moveTimer = 1
var allEnemiesDown = false
var score = 0
var enemyIsAlive = true


func _ready():
	spawnEnemies()
	moveEnemies()

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
