extends TileMap

var map = [
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
			[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
			]

var barrel = preload('res://Scenes/Barrel.tscn')

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
#	var x_counter = 0
#	var y_counter = 0
##	var block_counter = 0
#	var rng = RandomNumberGenerator.new()
#	for i in map:
#		for x in i:
##			print(x)
##			print(x_counter, '. ', y_counter)
#			if x == 1:
#				set_cellv(Vector2(y_counter, x_counter), 1)
##			else:
##		
#			y_counter += 1
#		x_counter += 1
#		y_counter = 0

	pass
	

func generate_map():
	var x_counter = 0
	var y_counter = 0
#	var block_counter = 0
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for i in map:
		for x in i:
			var random_number = rng.randf_range(0, 10)
#			print(x)
#			print(x_counter, '. ', y_counter)
			if x == 1:
				set_cellv(Vector2(y_counter, x_counter), 1)
			else:
				if random_number >= 9:
					set_cellv(Vector2(y_counter, x_counter), 0)
				else: 
					set_cellv(Vector2(y_counter, x_counter), -1)
#		
			y_counter += 1
		x_counter += 1
		y_counter = 0
		
	
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
