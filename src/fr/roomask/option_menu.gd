extends Control

@onready var _master_bus_index = AudioServer.get_bus_index("Master")
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
	
func _on_h_slider_value_changed(value: float) -> void:
	var volume_db = linear_to_db(value)
	
	AudioServer.set_bus_volume_db(_master_bus_index, volume_db)
	
	if value == 0:
		AudioServer.set_bus_mute(_master_bus_index, true)
	else:
		AudioServer.set_bus_mute(_master_bus_index, false)


func _on_button_pressed() -> void:
	await play_anim(anim_bouton) 
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
