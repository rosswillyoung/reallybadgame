extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 100
var timer = 0
var random_direction = RandomNumberGenerator.new()
var damage = 10
var rng = RandomNumberGenerator.new()
# signal died
# signal hit_player
#var player_seen = false
#var main_player


func get_direction():
	random_direction.randomize()
	velocity.y = random_direction.randf_range(-1, 1)
	velocity.x = random_direction.randf_range(-1, 1)
	velocity = velocity * speed


# Called when the node enters the scene tree for the first time.
func _ready():
	get_direction()
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
#	velocity = velocity * speed
#	position += motion
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity *= -1
	timer += delta


#	if player_seen:
#		follow_player(main_player)
#	if is_on_floor():
#		velocity *= -1


func _on_Area2D_area_entered(area):
#	print(area.get_parent().is_in_group('enemies'))
	if area.get_parent().is_in_group('enemies'):
		pass
	elif area.get_parent().is_in_group('breakable'):
		pass
#	elif area.get_parent().is_in_group('player'):
#		print('collided with player')
	else:
		die(self)


func _on_Area2D_body_entered(body):
	if body.get_parent().is_in_group('player'):
#		print('damage taken!')
		# emit_signal("hit_player", damage)
		die(self)


func die(enemy):
	self.velocity = Vector2.ZERO
	yield(get_tree().create_timer(0.5), 'timeout')
	emit_signal("died", enemy)
	self.remove_from_group('Enemies')
	self.queue_free()
