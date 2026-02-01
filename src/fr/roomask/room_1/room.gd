extends Node2D

@export 	var tileset_rsc : TileSet = preload("res://Assets/Room_1/room.tres")
@export	var view : int = 0

func _ready() -> void:
	var file = FileAccess.open("res://Data/room_1/room_1.json", FileAccess.READ)
	var data = file.get_as_text()
	var parsed = JSON.parse_string(data)
	get_parent().change_rt_room.connect(_on_realod)
	put_in_room(parsed)

func	 _on_realod() -> void:
	if (view == 1):
		view = 0
	else:
		view = 1
		
	var file = FileAccess.open("res://Data/room_1/room_1.json", FileAccess.READ)
	var data = file.get_as_text()
	var parsed = JSON.parse_string(data)
	var children = get_children()
	for child in children:
		child.queue_free()
	put_in_room(parsed)

func put_in_room(pData):
	var i  = 0
	var v = view
	
	while (i < pData.view[v].nb_assets):
		var new_layer = TileMapLayer.new()
		var new_data = pData.view[v].assets[i]
		new_layer.tile_set = tileset_rsc
		new_layer.name = "Assest_" + str(new_data.name)
		new_layer.z_index = new_data.z + 8
		new_layer.y_sort_enabled = true
		new_layer.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		new_layer.scale = Vector2(2, 2)
		new_layer.position.y = -(int(new_data.z)) * 32
		
		add_child(new_layer)
		var e = 0
		while (e < int(new_data.nbtiles)):
			new_layer.set_cell(Vector2i(int(new_data.pos[e].x), int(new_data.pos[e].y)), int(new_data.id), Vector2i(int(new_data.textures[e].x), int(new_data.textures[e].y)))
			e+=1
		i+=1
	
