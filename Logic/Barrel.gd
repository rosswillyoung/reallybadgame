extends StaticBody2D
signal barrel_broken
var timer = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


func _process(delta):
	timer += delta
	if timer >= .1:
		$SpawnChecker/CollisionShape2D.disabled = true


func _physics_process(delta):
	pass


func _exit_tree():
	emit_signal('barrel_broken', self)


func _on_SpawnChecker_body_entered(body):
	if body.is_in_group('player'):
		queue_free()
	pass  # Replace with function body.
