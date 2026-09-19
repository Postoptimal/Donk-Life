extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var sprites: Node2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		if direction!=0:
			flip_sprite(sign(direction)<0)
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func flip_sprite(flip:bool):
	for s:Sprite2D in sprites.get_children():
		s.flip_h = flip	
