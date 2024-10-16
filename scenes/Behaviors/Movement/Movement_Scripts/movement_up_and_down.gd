extends MovementBehaviorNode

@onready var speed: float = get_parent().enemy_resource.speed
var target_y = 0.0
var amplitude = 300.0
var frequency = 0.05
var direction = 1

func _physics_process(delta: float) -> void:

	if get_parent().global_position.y < 100:
		direction = 1
	elif get_parent().global_position.y > 400:
		direction = -1
		
	get_parent().global_position.y += (direction * amplitude) * frequency * delta

	if global_position.y > 400:
		global_position.y = 400
	elif global_position.y < 100:
		global_position.y = 100
	
	# Default behavior (can be left empty or log a message)

	pass
