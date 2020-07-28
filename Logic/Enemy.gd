extends KinematicBody2D
var velocity = Vector2.ZERO
var speed = 100
var timer
var random_direction = RandomNumberGenerator.new()
signal died

func get_direction():
	random_direction.randomize()
	velocity.y = random_direction.randf_range(-1, 1)
	velocity.x = random_direction.randf_range(-1, 1)
	velocity = velocity * speed


# Called when the node enters the scene tree for the first time.
func _ready():
	get_direction()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
#	velocity = velocity * speed
#	position += motion
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity *= -1
#	if is_on_floor():
#		velocity *= -1




func _on_Area2D_area_entered(area):
#	print(area.get_parent().is_in_group('enemies'))
	if area.get_parent().is_in_group('enemies'):
		pass
#	elif area.get_parent().is_in_group('player'):
#		print('collided with player')
	else:
		queue_free()



func _on_Area2D_body_entered(body):
	if body.get_parent().is_in_group('player'):
#		print('damage taken!')
		Global.player_health -=10
#		print(Global.player_health)
		queue_free()
		

