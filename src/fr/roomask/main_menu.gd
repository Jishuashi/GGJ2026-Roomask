extends Control

# Remplace les chemins ci-dessous par tes vrais fichiers
@export var anim_lancement : SpriteFrames = preload("res://Assets/Main _menu/animation login.tres")
@export var anim_bouton : SpriteFrames = preload("res://Assets/Main _menu/new_sprite_frames.tres")

func _ready() -> void:
	play_anim(anim_lancement)

func play_anim(ressource_frames : SpriteFrames):
	var animated_sprite = AnimatedSprite2D.new()
	animated_sprite.sprite_frames = ressource_frames
	animated_sprite.position = size / 2
	add_child(animated_sprite)
	animated_sprite.play("default")
	
	await get_tree().create_timer(1.0).timeout
	animated_sprite.queue_free()

func _on_start_pressed() -> void:
	await play_anim(anim_bouton) 
	get_tree().change_scene_to_file("res://Scenes/room_1.tscn")

func _on_option_pressed() -> void:
	await play_anim(anim_bouton)
	get_tree().change_scene_to_file("res://Scenes/option_menu.tscn")

func _on_quit_pressed() -> void:
	await play_anim(anim_bouton)
	get_tree().quit()
