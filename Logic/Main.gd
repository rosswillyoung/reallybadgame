extends Node2D

var barrel = preload('res://Scenes/Barrel.tscn')
var small_enemy = preload('res://Scenes/Enemy.tscn')
var rng = RandomNumberGenerator.new()
var spawn_counter = 0
var enemy_list = []
var barrel_list = []


# Spawn a group of enemies in random locations
func spawn_enemies(number_of_enemies):
	spawn_counter += 1
	if spawn_counter % 10 == 0:
		print('Spawn Boss')
	else:
		for i in range(10):
			var new_enemy = small_enemy.instance()
			self.add_child(new_enemy)
			rng.randomize()
			var random_x = rng.randf_range(64, 800 - 64)
			var random_y = rng.randf_range(64, 600 - 64)
			var enemy_position = Vector2(random_x, random_y)
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func generate_barrels(number_of_barrels):
	var used_cells = $TileMap/TileMap.get_used_cells()
	for i in used_cells.size():
		var object = $TileMap/TileMap.get_cellv(used_cells[i])
		if object == 0:
			var barrel_instance = barrel.instance()
			add_child(barrel_instance)
			barrel_instance.position.x = $TileMap/TileMap.map_to_world(used_cells[i]).x + 30
			barrel_instance.position.y = $TileMap/TileMap.map_to_world(used_cells[i]).y + 20
	$TileMap/TileMap.clear()


func enemy_died(enemy):
	enemy_list.erase(enemy)
#	print(enemy_list)
	# Check how many enemies are in the scene and remove all [DeletedObjects] from enemy_list
#	for i in enemy_list:
#		if !is_instance_valid(i):
#			enemy_list.erase(i)

	# Spawn more enemies and barrels if there are 1 or less enemies left
	if enemy_list.size() < 1:
		spawn_enemies(10)
		$TileMap/TileMap.generate_map()
		generate_barrels(10)


func on_barrel_broken():
	for i in barrel_list:
		if ! is_instance_valid(i):
			barrel_list.erase(i)


func game_over():
	print('You have died, game over.')
