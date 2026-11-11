extends Control

func _ready() -> void:
	# FIRST Check for an existing config file
	# If found, load all data in so player can resume progress
	# If none found, create a new empty one
	pass

func _on_button_pressed() -> void:
	get_tree().call_group("Menu Items","queue_free")
	$uis_presentation.visible = true
	
func _on_settings_pressed() -> void:
	$uis_settings.visible = !$uis_settings.visible

func _on_button_mouse_entered()   -> void: $VBoxContainer/Button.offset_transform_rotation = -0.07
func _on_button_mouse_exited()    -> void: $VBoxContainer/Button.offset_transform_rotation = 0.00
func _on_settings_mouse_entered() -> void: $VBoxContainer/Settings.offset_transform_rotation = -0.07
func _on_settings_mouse_exited()  -> void: $VBoxContainer/Settings.offset_transform_rotation = 0.00
