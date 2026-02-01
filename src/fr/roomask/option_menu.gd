extends Control

@onready var _master_bus_index = AudioServer.get_bus_index("Master")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_h_slider_value_changed(value: float) -> void:
	var volume_db = linear_to_db(value)
	
	AudioServer.set_bus_volume_db(_master_bus_index, volume_db)
	
	if value == 0:
		AudioServer.set_bus_mute(_master_bus_index, true)
	else:
		AudioServer.set_bus_mute(_master_bus_index, false)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
