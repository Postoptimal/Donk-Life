extends CharacterBody2D

# Mode selection
enum PlayerMode {RACING, SWIMMING, RUNNING, CLIMBING}
@export var player_mode: PlayerMode

# Variables
@export var GRAVITY: float = 1 ## Acceleration due to gravity, scaled to x100 px/s^2
@export var init_global_pos: Vector2 = Vector2(160, 750)
var acceleration: Vector2 = Vector2.ZERO ## Results in changes in velocity (this is changed in script depending on the situation)


# RACING Mode
@export_group("Racing")
@export var smth_cool: String = "=]" # placeholder lmao



# SWIMMING Mode
@export_group("Swimming")
@export var jump_strength: float = 1
@export var dive_strength: float = 1
@export var swim_speed: float = 1 # horizontal
@export var WATER_DRAG: float = 10 ## Proportionality constant for deceleration in water (a = -k * v^2)
@export_range(0.0, 1.0, 0.05) var BUOYANCY_RATIO: float = 0.5 ## Proportionality constant for buoyant force (F = -k * g)
var swim_state: int = SwimState.SURFACE
var check_hitting_ground: bool = false

@export_subgroup("On Surface?")
## What y value is considered "on the surface"
@export var surface_y: float = 750
@export var surface_range_y: float = 20
enum SwimState {SKY, SURFACE, UNDERWATER}

## All the required code for when the player is in the mode SWIMMING.
func swim_controls() -> void:
	update_swim_state()
	swim_horizontal_movement()
	swim_jump()
	swim_dive()
	swim_forces()
	
	print(
		"Velocity: " + str(velocity.y) + "\tHeight: " + str(global_position.y) + "\tAcceleration: " + str(acceleration.y)
	)

## Updates whether player is in SKY, SURFACE, or UNDERWATER
func update_swim_state() -> void:
	if global_position.y > surface_y + surface_range_y:
		swim_state = SwimState.UNDERWATER
	elif global_position.y < surface_y - surface_range_y:
		swim_state = SwimState.SKY
	else:
		swim_state = SwimState.SURFACE

## Swims left/right based on inputs.
func swim_horizontal_movement() ->void:
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity.x = input_dir.x * swim_speed * 1000

## Jump when the right button is pressed and the player is on the surface
func swim_jump() -> void:
	var input_jump: float = Input.is_action_just_pressed("jump")

	# Jump only if on surface
	if input_jump and swim_state == SwimState.SURFACE:
		velocity.y = -1 * jump_strength * 1000
		check_hitting_ground = false

## Dive when the right button is pressed and the player is on the surface
func swim_dive() -> void:
	var input_dive: float = Input.is_action_just_pressed("move_down")
	
	# Dive only if on surface
	if input_dive and swim_state == SwimState.SURFACE:
		velocity.y = dive_strength * 1000
		check_hitting_ground = false

## Calculate acceleration for each swim state
func swim_forces() -> void:
	match swim_state:
		SwimState.SKY: acceleration.y = GRAVITY
		SwimState.UNDERWATER: acceleration.y = -1 * (WATER_DRAG * abs(velocity.y) * velocity.y + BUOYANCY_RATIO * GRAVITY)
		SwimState.SURFACE: acceleration.y = 0

# RUNNING Mode
@export_group("Running")
@export var run_speed: float = 10



# CLIMBING Mode
@export_group("Climbing")
@export var climb_speed: float = 10



# MAIN
func _ready() -> void:
	global_position = init_global_pos

func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	match player_mode:
		PlayerMode.RACING: pass
		PlayerMode.SWIMMING: swim_controls()
		PlayerMode.RUNNING: pass
		PlayerMode.CLIMBING: pass
	
	velocity += acceleration * delta
	move_and_slide()
