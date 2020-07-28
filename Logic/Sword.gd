extends RigidBody2D

signal attack_finished

onready var animation_player = $AnimationPlayer

const IDLE = 0
const ATTACK = 1
var current_state = IDLE
signal enemy_hit


export (int) var damage = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	
func attack():
#	if direction == 'right':
#		_change_state(ATTACK, 'attack_right')
#	elif direction == 'left':
	_change_state(ATTACK)
	
func _change_state(new_state):
	current_state = new_state
	match current_state:
		IDLE:
			set_physics_process(false)
		ATTACK:
			set_physics_process(true)
			animation_player.play("attack_right")
			
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CollisionDetection_body_entered(body):
	if body.is_in_group('enemies'):
#		print('sword hit enemy')
		emit_signal('enemy_hit')
#		queue_free()
	pass # Replace with function body.
