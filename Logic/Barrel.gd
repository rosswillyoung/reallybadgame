extends StaticBody2D
signal barrel_broken

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	pass
	
func _exit_tree():
	emit_signal('barrel_broken')



