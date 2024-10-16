extends MovementBehaviorNode

@onready var speed: float = get_parent().enemy_resource.speed

func _physics_process(delta: float) -> void:
	get_parent().global_position.x -= speed * delta
	
	# cuando sale de pantalla se borra
	#if (get_parent().global_position.x < -100):
		#get_parent().queue_free()
		
	# Default behavior (can be left empty or log a message)
	pass
