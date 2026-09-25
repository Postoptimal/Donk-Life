extends Node2D


func _on_button_pressed() -> void:
	GameManager.loadscene("res://Scenes/Menu/UIS_menu.tscn")


func _on_area_race_mouse_entered() -> void:
	print("Racism?")


func _on_area_race_mouse_exited() -> void:
	print("Not racism?")


func _on_area_swim_mouse_entered() -> void:
	print("Swim?")


func _on_area_swim_mouse_exited() -> void:
	print("No Swim")
