extends Node2D

@export var anim_lancement : SpriteFrames = preload("res://Assets/Main _menu/animation login.tres")
signal change_rt_room

func _ready() -> void:
	play_anim(anim_lancement)

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
	
func _input(event):
	if event.is_action_pressed("Move_Scene"):
		await play_anim2(anim_lancement)
		change_rt_room.emit()
		await play_anim(anim_lancement)
	if event.is_action_pressed("quit"):
		await play_anim2(anim_lancement)
		get_tree().quit()
		await play_anim(anim_lancement)


func _on_button_pressed() -> void:
	await play_anim2(anim_lancement)
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
