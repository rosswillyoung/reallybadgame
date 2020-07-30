extends KinematicBody2D

const TIME_TO_EXPLODE = 1

var time = 0
#signal barrel_broken


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Countdown")
	pass # Replace with function body.

func on_timer_timeout():
	print('bomb should explode')
	$AnimationPlayer.play("Explode")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time > TIME_TO_EXPLODE:
		$AnimationPlayer.play("Explode")
	if time > TIME_TO_EXPLODE + .5:
		queue_free()
	pass


func _on_ExplosionArea_body_entered(body):
#	print(get_parent().get_parent().get_child(1))
	
	if body.is_in_group('breakable'):
#		print('break')
#		emit_signal("barrel_broken")
		body.queue_free()
#	print(body)
#	print(TileMap.world_to_map(body.position))
	pass # Replace with function body.

