extends Node2D

var barrel = preload('res://Scenes/Barrel.tscn')
var enemy = preload('res://Scenes/Enemy.tscn')
var rng = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func spawn_enemies(number_of_enemies):
	var enemy_list = []
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
	return enemy_list

# Called when the node enters the scene tree for the first time.
func _ready():
	$TileMap/TileMap.generate_map()
	generate_barrels()
	spawn_enemies(10)
	
#	$TileMap/TileMap.generate_map($Player.position, spawn_enemies(10))
#	print(enemy_list)
	
#	$Player/KinematicBody2D/Sword/AnimationPlayer.play("attack 2")
#	$TileMap/TileMap.set_cell(64 * 2, 64 * 2, 0)
#	for child in get_children():
#		print(child.is_in_group('enemies'))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.get_child_count() == 2:
		$TileMap/TileMap.generate_map()
		generate_barrels()
		spawn_enemies(10)
#		spawn_enemies(10)
	pass
	
func generate_barrels():
#	for i in range(20):
#		var new_barrel = barrel.instance()
#		self.add_child(new_barrel)
#		rng.randomize()
#		var random_x = rng.randf_range(64, 800 - 64)
#		var random_y = rng.randf_range(64, 600 - 64)
#		new_barrel.global_position = Vector2(random_x, random_y)
#
	var used_cells = $TileMap/TileMap.get_used_cells()
#	print(used_cells)
	for i in used_cells.size():
		var object = $TileMap/TileMap.get_cellv(used_cells[i])
#		print(object)
		if object == 0:
			var barrel_instance = barrel.instance()
			add_child(barrel_instance)
			barrel_instance.position = $TileMap/TileMap.map_to_world(used_cells[i])
	$TileMap/TileMap.clear()
