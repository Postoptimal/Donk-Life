extends Node2D

# Nodes
@onready var player: CharacterBody2D
@onready var clouds: Array[Sprite2D] = [$Sky/Cloud1, $Sky/Cloud2, $Sky/Cloud3]
@onready var endzone: Area2D = $Endzone
@onready var spawn_point: Marker2D = $SpawnPoint # temporary before cleaning up.
@export var obstacle_types: Array[PackedScene]

# Constants & Variables
@export var obstacle_speed: float = 500 ## How fast obstacles should travel when spawned.
@export_group("Initial Obstacle Generation")
## Average delay time when spanwing initial obstacles
@export var delay_mean: float
## Max delay time - Min delay time when spawning initial obstacles
@export var delay_range: float

# 1. Instantiate obstacles
# 2. Make obstacles move to the left at a specific speed - perhaps variable speed?
# 3. Delete obstacles in end zone
func obstacle_remove(body: Node2D) -> void:
	if body is Player: print("oops!")
	body.queue_free()
	print("pop!")
	# Create new obstacle after random amount of time (within a range)
	await get_tree().create_timer(randf() * 1.5).timeout
	obstacle_create()

func obstacle_create() -> void:
	var new_obstacle = obstacle_types[randi() % len(obstacle_types)].instantiate() # random obstacle type in the provided list
	get_tree().current_scene.add_child(new_obstacle)
	new_obstacle.global_position = spawn_point.global_position
	new_obstacle.velocity = obstacle_speed
	print("yay!")
	print("Position: " + str(new_obstacle.global_position.x))
	await get_tree().create_timer(1).timeout
	print("New Position: " + str(new_obstacle.global_position.x))

func _ready() -> void:
	endzone.body_entered.connect(obstacle_remove)
	for i in range(2):
		obstacle_create()
		await get_tree().create_timer(randf() * delay_range + delay_mean).timeout
	obstacle_create()

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass
