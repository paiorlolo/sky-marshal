class_name Cloud
extends AnimatedSprite2D

var speed: float = randi_range(40, 55)

func _ready() -> void:
	# seteo una posicion vertical random
	var max_y_pos = 2 * get_viewport().get_visible_rect().size.y / 3
	var y_starting_position = randi_range(100, max_y_pos)
	position.y = y_starting_position

	# se posiciona fuera de pantalla, del lado derecho
	position.x = get_viewport().get_visible_rect().size.x + 100
	
	# le asigno una textura random seleccionando un frame de su animacion
	var texture_index = randi_range(0, 5)
	set_frame_and_progress(texture_index, 0.0)
	pause()

	pass 


func _physics_process(delta: float) -> void:
	# flota hacia el lado izquierdo constantemente
	global_position.x -= speed * delta
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.
