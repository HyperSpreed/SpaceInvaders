extends Area2D

@export var speed: float = 100.0
var direction: Vector2 = Vector2()
var start_position = Vector2.ZERO
var value = 500

func _ready():
	_initialize_direction()
	connect("tree_exiting", Callable(self, "_on_spaceship_exiting"))

func _initialize_direction():
	if position.x < get_viewport_rect().size.x / 2:
		direction = Vector2(1, 0)
	else:
		direction = Vector2(-1, 0)

func _check_off_screen():
	if position.x < -50 or position.x > get_viewport_rect().size.x + 50:
		queue_free()

func _process(delta):
	position += direction * speed * delta
	_check_off_screen()

func _on_spaceship_exiting():
	var scoreEachEnemy = get_node("/root/Main")
	scoreEachEnemy.score += value
	get_node("/root/Main").updateScore()
	#$AnimationPlayer.play("explode")      #USE THIS TO PLAY AN EXPLODING ANIMATION
	set_deferred("monitorable",false)
	#await $AnimationPlayer.animation_finished       #USE THIS TO PLAY AFTER THE END OF ANIMATION
	hide()
	#queue_free()
