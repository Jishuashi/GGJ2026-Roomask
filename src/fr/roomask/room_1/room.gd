extends Node2D

@export 	var tileset_rsc : TileSet = preload("res://Assets/Room_1/room.tres")
@export	var view : int = 0

func _ready() -> void:
	var file = FileAccess.open("res://Data/room_1/room_1.json", FileAccess.READ)
	var data = file.get_as_text()
	var parsed = JSON.parse_string(data)
	get_parent().change_rt_room.connect(_on_realod)
	get_parent().close_puzzle.connect(delpuzzle)
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

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		for child in get_children():
			if (child is TileMapLayer && child.name == "Assest_desk_mid_click"):
				var local_pos = child.get_local_mouse_position()
				var map_coords = child.local_to_map(local_pos)
				print(map_coords)
				if ((map_coords == Vector2i(3, 0) || map_coords == Vector2i(4, 0))):
					await play_anim2(anim_lancement)
					print_puzzle()
					var children = get_parent().get_children()	
					for child2 in children:
						if(child2.name == 'Button2'):
							child2.show()
					await play_anim(anim_lancement)
					return
		

func print_puzzle():
	var puzzle = Sprite2D.new()
	puzzle.texture = load("res://Assets/Room_1/puzzle.png")
	puzzle.scale = Vector2(0.6, 0.6)
	puzzle.name = "get_mask"
	puzzle.position.x += 32
	puzzle.z_index = 15
	
	add_child(puzzle)
	
func delpuzzle():
	var children = get_children()
	
	for child in children:
		if (child.name == "get_mask"):
			await play_anim2(anim_lancement)
			child.queue_free()
			await play_anim(anim_lancement)

@export var anim_lancement : SpriteFrames = preload("res://Assets/Main _menu/animation login.tres")

func play_anim(ressource_frames : SpriteFrames):
	var animated_sprite = AnimatedSprite2D.new()
	animated_sprite.sprite_frames = ressource_frames
	add_child(animated_sprite)
	
	animated_sprite.centered = true
	animated_sprite.z_index = 16
	
	var camera = get_viewport().get_camera_2d()
	if camera:
		animated_sprite.global_position = camera.get_screen_center_position()
	else:
		animated_sprite.global_position = Vector2.ZERO
	
	animated_sprite.play("default")
	await get_tree().create_timer(1.0).timeout
	animated_sprite.queue_free()
	
func play_anim2(ressource_frames : SpriteFrames):
	var animated_sprite = AnimatedSprite2D.new()
	animated_sprite.sprite_frames = ressource_frames
	add_child(animated_sprite)
	
	animated_sprite.centered = true
	animated_sprite.z_index = 16
	
	var camera = get_viewport().get_camera_2d()
	if camera:
		animated_sprite.global_position = camera.get_screen_center_position()
	else:
		animated_sprite.global_position = Vector2.ZERO
	
	animated_sprite.play("end")
	await get_tree().create_timer(1.0).timeout
	animated_sprite.queue_free()
