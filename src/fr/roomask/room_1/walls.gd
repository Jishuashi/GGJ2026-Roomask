extends Node2D

@export var layers : int = 8
@export var width : int = 10
@export var tileset_rsc : TileSet = preload("res://Assets/Room_1/walls.tres") 

func _ready() -> void:
	create_walls_layer() 

func create_walls_layer():
	var size = 32
	var z = -1
		
	while (z < layers):
		var new_layer = TileMapLayer.new()
		
		new_layer.name = "Layers_" + str(z)
		new_layer.tile_set = tileset_rsc
		new_layer.z_index = z
		new_layer.y_sort_enabled = true
		new_layer.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		new_layer.scale = Vector2(4, 4)
		new_layer.position.y = -z * (size * 2)
		
		add_child(new_layer)
		
		if (z == -1):
			var x = -2
			var y = -1 
			while (y < (width - 1)):
				new_layer.set_cell(Vector2i(x, y), 0, Vector2i(7, 0))
				y += 1
			y = -2
			x = -1 
			while (x < (width - 1)):
				new_layer.set_cell(Vector2i(x, y), 0, Vector2i(6, 0))
				x += 1
		else:
			var x = -2
			var y = -1 
			while (y < (width - 1)):
				if (y == (width - 2) && z != 7):
					if (z % 2 == 0):
						new_layer.set_cell(Vector2i(x, y), 0, Vector2i(4, 0))
					else:
						new_layer.set_cell(Vector2i(x, y), 0, Vector2i(4, 1))
				elif (z == 7):
					if (z % 2 == 0):
						new_layer.set_cell(Vector2i(x, y), 0, Vector2i(2, 0))
					else:
						new_layer.set_cell(Vector2i(x, y), 0, Vector2i(2, 1))
				else:
					if (z % 2 == 0):
						new_layer.set_cell(Vector2i(x, y), 0, Vector2i(0, 0))
					else:
						new_layer.set_cell(Vector2i(x, y), 0, Vector2i(0, 1))
				y += 1
			y = -2
			x = -1 
			while (x < (width - 1)):
				if (x == (width - 2) && z != 7):
					if (z % 2 == 0):
						new_layer.set_cell(Vector2i(x, y), 0, Vector2i(5, 1))
					else:
						new_layer.set_cell(Vector2i(x, y), 0, Vector2i(5, 0))
				else:
					if (z == 7):
						if (z % 2 == 0):
							new_layer.set_cell(Vector2i(x, y), 0, Vector2i(3, 1))
						else :
							new_layer.set_cell(Vector2i(x, y), 0, Vector2i(3, 0))
					else :
						if (z % 2 == 0):
							new_layer.set_cell(Vector2i(x, y), 0, Vector2i(1, 1))
						else :
							new_layer.set_cell(Vector2i(x, y), 0, Vector2i(1, 0))
				x += 1
				if (z == 7):
					new_layer.set_cell(Vector2i(-3, -3), 0, Vector2i(6, 1))
		z += 1
