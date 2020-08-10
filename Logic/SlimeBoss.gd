extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 100
var timer = 0
var random_direction = RandomNumberGenerator.new()
var damage = 30
var _health = 100
var rng = RandomNumberGenerator.new()
signal died
signal hit_player
#var player_seen = false
#var main_player


func get_direction():
	random_direction.randomize()
	velocity.y = random_direction.randf_range(-1, 1)
	velocity.x = random_direction.randf_range(-1, 1)
	velocity = velocity * speed


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_parent().get_children():
		if i.is_in_group('breakable'):
			i.queue_free()
	get_direction()
	$TextureProgress.value = 100
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
#	velocity = velocity * speed
#	position += motion
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity *= -1
	timer += delta


func _on_DamageArea_body_entered(body):
	if body.is_in_group("player"):
		print('player hit boss')
		emit_signal("hit_player", damage)
	elif body.is_in_group('weapons'):
		take_damage(body.damage)
	print(body)


func take_damage(weapon_damage):
	print('boss taken ', weapon_damage, ' damage')
	_health -= weapon_damage
	$TextureProgress.value -= weapon_damage
	if _health <= 0:
		die(self)


func die(enemy):
	self.velocity = Vector2.ZERO
	yield(get_tree().create_timer(0.5), 'timeout')
	emit_signal("died", enemy)
	self.remove_from_group('Enemies')
	self.queue_free()
