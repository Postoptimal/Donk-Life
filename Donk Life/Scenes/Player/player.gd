extends CharacterBody2D

@onready var swimming_animation: AnimatedSprite2D = $Sprite/CanvasGroup/Swim

# Mode selection
enum PlayerMode {RACING, SWIMMING, RUNNING, CLIMBING}
@export var player_mode: PlayerMode

# Variables
@export var gravity: float = 100
var swim_state: int = SwimState.SURFACE

# RACING Mode
@export_group("Racing")
@export var smth_cool: String = "=]" # placeholder lmao

# SWIMMING Mode
@export_group("Swimming")
@export var jump_strength: float = 1
@export var dive_strength: float = 1
@export var swim_speed: float = 1 # horizontal

## What y value is considered "on the surface"
@export_subgroup("On Surface?")
@export var surface_y: float = 750
@export var surface_range_y: float = 20
enum SwimState {SKY, SURFACE, UNDERWATER}

func swim_controls() -> void:
	update_swim_state()
	swim_horizontal_movement()
	swim_jump()
	swim_dive()

## Updates whether player is in SKY, SURFACE, or UNDERWATER
func update_swim_state() -> void:
	if global_position.y > surface_y + surface_range_y:
		swim_state = SwimState.UNDERWATER
	elif -1 * global_position.y > surface_y + surface_range_y:
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
		
	# Check when to stop falling ???

## Dive when the right button is pressed and the player is on the surface
func swim_dive() -> void:
	var input_dive: float = Input.is_action_just_pressed("move_down")
	
	# Dive only if on surface
	if input_dive and swim_state == SwimState.SURFACE:
		velocity.y = dive_strength * 1000
	
	# Check when to stop diving ???


# RUNNING Mode
@export_group("Running")
@export var run_speed: float = 10

# CLIMBING Mode
@export_group("Climbing")
@export var climb_speed: float = 10

# MAIN
func _ready() -> void:
	swimming_animation.hide()

func _process(_delta: float) -> void:
	if swim_state == SwimState.SURFACE:
		swimming_animation.show()
	else:
		swimming_animation.hide()

func _physics_process(_delta: float) -> void:
	match player_mode:
		PlayerMode.RACING: pass
		PlayerMode.SWIMMING: swim_controls()
		PlayerMode.RUNNING: pass
		PlayerMode.CLIMBING: pass
	move_and_slide()
