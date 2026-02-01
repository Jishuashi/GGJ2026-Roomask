extends Node2D

signal change_rt_room

func _input(event):
	if event.is_action_pressed("Move_Scene"):
		change_rt_room.emit()
		
