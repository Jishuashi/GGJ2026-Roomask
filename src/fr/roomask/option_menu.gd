extends Control
@onready var eastereeg: AudioStreamPlayer = $eastereeg

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func easter_egg_on_button_pressed() -> void:
	eastereeg.play()
	get_tree().change_scene_to_file("res://Scenes/easter_egg.tscn")
	
