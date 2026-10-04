class_name Player extends CharacterBody2D

# Nodes
@onready var cooldown_label: Label = $"../CooldownLabel" # temporary
@onready var player_label: Label = $"../PlayerLabel" # also temporary


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
@export var SWIM_COOLDOWN: float = 0.5 ## Max detection cooldown after jumping or diving
@export var jump_strength: float = 1
@export var dive_strength: float = 1
@export var swim_speed: float = 1 # horizontal
@export_range(0.0, 1.0, 0.01) var BUOYANCY_RATIO: float = 0.5 ## Proportionality constant for buoyant force (F = -k * g)
var swim_state: int = SwimState.SURFACE ## Stores whether player is underwater, on the surface or in the sky
var swim_cooldown_timer: float = 0 ## Prevent detection for short period after jumping or diving

@export_subgroup("Checking If On Surface")
@export var surface_y: float = 750 ## What y value is considered "on the surface"
@export var surface_range_y: float = 20
enum SwimState {SKY, SURFACE, UNDERWATER}

## All the required code for when the player is in the mode SWIMMING.
func swim_controls() -> void:
	cooldown_label.text = "%.2f" % swim_cooldown_timer
	update_swim_state()
	swim_horizontal_movement()
	swim_jump()
	swim_dive()
	swim_forces()
	
	var player_label_dict = {"h": global_position.y, "v": velocity.y, "a": acceleration.y}
	player_label.text = """Height: {h}
	Velocity: {v}
	Acceleration: {a}""".format(player_label_dict)
	
	# cooldown timer
	if swim_cooldown_timer > 0:
		swim_cooldown_timer -= get_physics_process_delta_time()

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
	if input_jump and swim_state == SwimState.SURFACE and swim_cooldown_timer <= 0:
		velocity.y = -1 * jump_strength * 1000
		swim_cooldown_timer = SWIM_COOLDOWN

## Dive when the right button is pressed and the player is on the surface
func swim_dive() -> void:
	var input_dive: float = Input.is_action_just_pressed("move_down")
	
	# Dive only if on surface
	if input_dive and swim_state == SwimState.SURFACE and swim_cooldown_timer <= 0:
		velocity.y = dive_strength * 1000
		swim_cooldown_timer = SWIM_COOLDOWN

## Calculate acceleration for each swim state (and set velocity to zero after cooldown finishes)
func swim_forces() -> void:
	match swim_state:
		SwimState.SKY: acceleration.y = GRAVITY
		SwimState.UNDERWATER: acceleration.y = -1 * BUOYANCY_RATIO * GRAVITY
		SwimState.SURFACE:
			if swim_cooldown_timer <= 0:
				velocity.y = 0
				global_position.y = surface_y
			acceleration.y = 0

# RUNNING Mode
@export_group("Running")
@export var run_speed: float = 10



# CLIMBING Mode
@export_group("Climbing")
@export var climb_speed: float = 10



# MAIN
func _ready() -> void:
	global_position = init_global_pos
	swim_cooldown_timer = 0

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
