class_name Player
extends  CharacterBody2D

@export var speed:float = 600.0

var is_on_wall:bool = true
var vel: float = 0.00
var inp = 0.0

func _ready() -> void:
	#Get the movement and input nodes
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
		inp = Input.get_axis("move_left","move_right")
	else:
		inp = 0.0

func _process(delta: float) -> void:
	velocity = Vector2(vel,0)
	print(velocity, vel)
	is_on_wall = move_and_slide()
	if inp == 0:
		return
	is_on_wall = false
	vel = speed * sign(inp)
	
