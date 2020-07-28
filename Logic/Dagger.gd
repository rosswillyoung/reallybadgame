extends RigidBody2D
var speed = 400
var velocity = Vector2.ZERO
signal enemy_hit


# Called when the node enters the scene tree for the first time.
func _ready():
	self.throw_at_mouse()
	pass # Replace with function body.

func throw_at_mouse():
	var direction = (get_global_mouse_position() - self.global_position).normalized()
#	self.linear_velocity = direction * speed
	velocity = direction * speed
#	print(linear_velocity)
#	self.global_position += direction * speed
#	move_and_collide()
#	$AnimationPlayer.play("Rotate")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.rotate(.4)
	position += velocity * delta
#	self.position = get_global_mouse_position() - self.global_position
	pass


#func _on_Dagger_body_entered(body):
#	if body.is_in_group('enemies'):
#		print('dagger hit enemy')
#	pass # Replace with function body.


func _on_CollisionDetection_body_entered(body):
	if body.is_in_group('enemies'):
#		print('dagger hit enemy')
		emit_signal("enemy_hit")
		queue_free()
	elif body.get_collision_layer() == 4:
		queue_free()
	pass # Replace with function body.
