extends Node2D

var barrel = preload('res://Scenes/Barrel.tscn')
var small_enemy = preload('res://Scenes/Enemy.tscn')
var boss_enemy = preload('res://Scenes/SlimeBoss.tscn')
var rng = RandomNumberGenerator.new()
var spawn_counter = 0
var enemy_list = []
var barrel_list = []


# Spawn a group of enemies in random locations
func spawn_enemies(number_of_enemies):
	spawn_counter += 1
	if spawn_counter % 5 == 0:
		spawn_boss()
	else:
		for i in range(number_of_enemies):
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
		$TileMap/TileMap.generate_map()
		generate_barrels()


func spawn_boss():
	var boss = boss_enemy.instance()
	self.add_child(boss)
	var boss_position = Vector2(300, 400)
	boss.global_position = boss_position
	boss.connect('died', self, 'enemy_died')
	boss.connect('hit_player', $Player/KinematicBody2D, 'take_damage')


# Called when the node enters the scene tree for the first time.
func _ready():
#	$TileMap/TileMap.generate_map()
	generate_barrels()
	# spawn_enemies(10)
	spawn_boss()
	$Player/KinematicBody2D.connect('player_died', self, 'game_over')


# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass


func generate_barrels():
	var used_cells = $TileMap/TileMap.get_used_cells()
	for i in used_cells.size():
		var object = $TileMap/TileMap.get_cellv(used_cells[i])
		if object == 0:
			var barrel_instance = barrel.instance()
			add_child(barrel_instance)
			barrel_instance.position.x = $TileMap/TileMap.map_to_world(used_cells[i]).x + 30
			barrel_instance.position.y = $TileMap/TileMap.map_to_world(used_cells[i]).y + 20
			barrel_list.append(barrel_instance)
			barrel_instance.connect('barrel_broken', self, '_on_Barrel_broken')
	$TileMap/TileMap.clear()
	# print(barrel_list)


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


func on_barrel_broken(broken_barrel):
	# broken_barrel.queue_free()
	barrel_list.erase(broken_barrel)
	# broken_barrel.queue_free()


func game_over():
	print('You have died, game over.')
