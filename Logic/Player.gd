extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 400
#enum Directions {RIGHT, LEFT, UP, DOWN}
var current_direction = 'right'
var dash_timer = null
var dash_delay = 2
var can_dash = true
export(NodePath) var PlayerPath
export var damage = 10
var dagger = preload("res://Scenes/Dagger.tscn")
var bomb = preload('res://Scenes/Bomb.tscn')

#signal dagger_thrown


# Called when the node enters the scene tree for the first time.
func _ready():
	dash_timer = Timer.new()
	dash_timer.set_one_shot(true)
	dash_timer.set_wait_time(dash_delay)
	dash_timer.connect('timeout', self, 'on_timer_complete')
	add_child(dash_timer)
	$Sword.connect('enemy_hit', self, 'on_Sword_enemy_hit')
	
	


func on_timer_complete():
	can_dash = true


func get_input():
	speed = 400
	velocity.x = 0
	velocity.y = 0
	if Input.is_action_pressed('d'):
		velocity.x += speed
#		change_state(Directions.RIGHT)
		current_direction = 'right'
#		$Sword.scale.x = 1
	if Input.is_action_pressed('a'):
		velocity.x -= speed
#		change_state(Directions.LEFT)
		current_direction = 'left'
#		$Sword.scale.x = -1
	if Input.is_action_pressed('w'):
		velocity.y -= speed
#		change_state(Directions.UP)
	if Input.is_action_pressed('s'):
		velocity.y += speed
#		change_state(Directions.DOWN)

#	Throw Dagger
	if Input.is_action_just_pressed('f'):
		var dagger_thrown = dagger.instance()
		dagger_thrown.connect('enemy_hit', self, 'on_Dagger_enemy_hit')
		dagger_thrown.position = self.position
		get_parent().add_child(dagger_thrown)
		print(Global.INNER_WIDTH)
#		
	if Input.is_action_just_pressed('e'):
		var bomb_dropped = bomb.instance()
		bomb_dropped.position = self.position
		get_parent().add_child(bomb_dropped)
		pass
		
#	Swing sword
	if Input.is_action_just_pressed("left_click"):
		$Sword.attack()
		
	if (Input.is_action_just_pressed("space")) && can_dash:
		speed *= 20
		can_dash = false
		
		dash_timer.start()
	# Stops sprite from moving faster if diagonal
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	self.look_at(get_global_mouse_position())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	pass
	
func on_Sword_enemy_hit():
	print('enemy hit by sword')
	
func on_Dagger_enemy_hit():
	print('enemy hit by dagger')
	
#func change_state(direction):
#	current_direction = direction
