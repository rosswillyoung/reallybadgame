extends Node2D

var barrel = preload('res://Scenes/Barrel.tscn')
var enemy = preload('res://Scenes/Enemy.tscn')
var rng = RandomNumberGenerator.new()
var enemies_killed = 0
var enemy_list = []
var barrel_list = []


func spawn_enemies(number_of_enemies):

	for i in range(10):
		var new_enemy = enemy.instance()
		self.add_child(new_enemy)
		rng.randomize()
		var random_x = rng.randf_range(64, 800 - 64)
		var random_y = rng.randf_range(64, 600 - 64)
		var enemy_position = Vector2(random_x, random_y)
		
#		new_enemy.position.x = random_x
#		new_enemy.position.y = random_y
		new_enemy.global_position = enemy_position
		enemy_list.append(new_enemy)
		new_enemy.connect('died', self, 'enemy_died')
		new_enemy.connect('hit_player', $Player/KinematicBody2D, 'take_damage')
#	return enemy_list

# Called when the node enters the scene tree for the first time.
func _ready():
#	$TileMap/TileMap.generate_map()
	generate_barrels(20)
	spawn_enemies(10)
	$Player/KinematicBody2D.connect('player_died', self, 'game_over')
#	print(enemy_list)
	
#	$TileMap/TileMap.generate_map($Player.position, spawn_enemies(10))
#	print(enemy_list)
	
#	$Player/KinematicBody2D/Sword/AnimationPlayer.play("attack 2")
#	$TileMap/TileMap.set_cell(64 * 2, 64 * 2, 0)
#	for child in get_children():
#		print(child.is_in_group('enemies'))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func generate_barrels(number_of_barrels):
#	for i in range(number_of_barrels):
#		var new_barrel = barrel.instance()
#		self.add_child(new_barrel)
#		rng.randomize()
#		var random_x = rng.randf_range(70, 800 - 64)
#		var random_y = rng.randf_range(70, 600 - 64)
#		new_barrel.global_position = Vector2(random_x, random_y)
#		barrel_list.append(new_barrel)
#		new_barrel.connect('barrel_broken', self, 'on_barrel_broken')
		
#
	var used_cells = $TileMap/TileMap.get_used_cells()
#	print(used_cells)
	for i in used_cells.size():
		var object = $TileMap/TileMap.get_cellv(used_cells[i])
#		print(object)
		if object == 0:
			var barrel_instance = barrel.instance()
			add_child(barrel_instance)
			barrel_instance.position.x = $TileMap/TileMap.map_to_world(used_cells[i]).x + 30
			barrel_instance.position.y = $TileMap/TileMap.map_to_world(used_cells[i]).y + 20
	$TileMap/TileMap.clear()
	
func enemy_died():
#	print('an enemy has died')
	for i in enemy_list:
		if !is_instance_valid(i):
			enemy_list.erase(i)
#		print(enemy_list)
#	print(enemy_list.size())
#	print(enemy_list)
	
	if enemy_list.size() <= 1:
		spawn_enemies(10)
		$TileMap/TileMap.generate_map()
		generate_barrels(10)
	enemies_killed += 1
	
func on_barrel_broken():
	for i in barrel_list:
		if !is_instance_valid(i):
			barrel_list.erase(i)
#	print('barrel broken')
#	print(barrel_list)
	
#func player_hit():
#	print('player hit by enemy')
#	$Player/KinematicBody2D/TextureProgress.value -= 5

func game_over():
	print('You have died, game over.')
