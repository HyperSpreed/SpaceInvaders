extends Area2D

var enemyHealth = 1
var initialHealth = 1

func _ready():
	enemyHealth = initialHealth
	$CollisionShape2D.disabled = false

func _on_CollisionShape2D_body_entered(body):
	if body.name == "bullet":
		enemyHealth -= 1
		if enemyHealth <= 0:
			queue_free()
			print(enemyHealth)
			#get_node("/root/Main/ScoreLabel").update_score()
			#hide()
			#$CollisionShape2D.disabled = true

func resetBrick():
	enemyHealth = initialHealth
	show()
	$CollisionShape2D.disabled = false
