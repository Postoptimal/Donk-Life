class_name SwimObstacle extends StaticBody2D

var velocity: float = 0.0; ## Speed at which it moves, determined by the minigame's code

func _physics_process(delta: float) -> void:
	global_position.x -= velocity * delta
