extends Node2D

@export_category("Scenes")
@export var Climbing:String
@export var Running:String
@export var Racing:String
@export var Swimming:String
@export var Menu:String

@export_category("Climbing")
@export var Mountain: Sprite2D
@export var Space: Sprite2D

@export_category("Swimming")
@export var Puddle: Sprite2D
@export var Roy: Sprite2D

@export_category("Running")
@export var Tower: Sprite2D

@export_category("Racing")
@export var Birb: Sprite2D

@export_category("Exit")
@export var Sign: Sprite2D

@export var zoom_value: float

func _on_cust_input_event(viewport: Node, event: InputEvent, shape_idx: int, area: int) -> void:
	if !event is InputEventMouseButton:
		return
	if event.is_released() or event.button_index > MOUSE_BUTTON_LEFT:
		return
	var text=""
	var level = ""
	match area:
		0:
			text = "Racing"
			level = Racing
		1:
			text = "Running"
			level = Running
		2:
			text = "Climbing"
			level = Climbing
		3:
			text = "Swimming"
			level = Swimming
		_:
			text = "Menu"
			level = Menu
	print(text)
	GameManager.loadscene(level)

func _on_mouse_entered(area: int) -> void:
	var new_scale = Vector2.ONE * 2.0
	match area:
		0:
			Birb.apply_scale(new_scale)
		1:
			Tower.apply_scale(new_scale)
		2:
			Mountain.apply_scale(new_scale/2*1.2)
			Space.apply_scale(new_scale/2*1.2)
		3:
			Puddle.apply_scale(new_scale)
			Roy.apply_scale(new_scale)
		_:
			Sign.apply_scale(new_scale)

func _on_mouse_exited(area: int) -> void:
	var new_scale = Vector2.ONE * 0.5
	match area:
		0:
			Birb.apply_scale(new_scale)
		1:
			Tower.apply_scale(new_scale)
		2:
			Mountain.apply_scale(new_scale*2/1.2)
			Space.apply_scale(new_scale*2/1.2)
		3:
			Puddle.apply_scale(new_scale)
			Roy.apply_scale(new_scale)
		_:
			Sign.apply_scale(new_scale)
