extends Control

# You need an array of images to be the slides
# Start at index 0/slide_count = 0
# And integrate that into the logic of the left/right button presses
# It is simple logic, a novice programmer can reverse engineer this file
# Also need to implement to change the Image container's image when u change slides

var slide_count: int = 0

func _on_left_pressed() -> void:
	if slide_count == 0: GameManager.loadscene("uid://jo11i74k7bv")
	else:
		slide_count -= 1
		$VBoxContainer/HBoxContainer/Right.text = "NEXT"
		if slide_count == 0: $VBoxContainer/HBoxContainer/Left.text = "SKIP"

func _on_right_pressed() -> void:
	if slide_count == 2: GameManager.loadscene("uid://jo11i74k7bv")
	else:
		slide_count += 1
		$VBoxContainer/HBoxContainer/Left.text = "PREV"
		if slide_count == 2: $VBoxContainer/HBoxContainer/Right.text = "PLAY"

func _on_left_mouse_entered()  -> void: $VBoxContainer/HBoxContainer/Left.offset_transform_rotation = -0.07
func _on_left_mouse_exited()   -> void: $VBoxContainer/HBoxContainer/Left.offset_transform_rotation = 0.00
func _on_right_mouse_entered() -> void: $VBoxContainer/HBoxContainer/Right.offset_transform_rotation = -0.07
func _on_right_mouse_exited()  -> void: $VBoxContainer/HBoxContainer/Right.offset_transform_rotation = 0.00
