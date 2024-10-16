class_name Marshall
extends Node2D

var rotation_speed: float = 5.0
@onready var brazo_der: Sprite2D = $brazo_der
@onready var brazo_izq: Sprite2D = $brazo_izq

var right_lantern_on: bool = false
var left_lantern_on: bool = false

# Variables to store stick movement and rotation
var left_stick_vector : Vector2
var right_stick_vector : Vector2
var left_stick_angle : float
var right_stick_angle : float

signal drop_supplies
signal shoot

signal change_order(newOrder: Global.Order)

func _ready() -> void:
	pass 

func _process(delta: float) -> void:

	if (
			right_lantern_on and left_lantern_on 
			and get_dir_right_arm() == Global.Direction.DOWN 
			and get_dir_left_arm() == Global.Direction.DOWN
		):
		drop_supplies.emit()
		pass
		
	if (
			right_lantern_on and left_lantern_on 
			and ( get_dir_right_arm() != Global.Direction.DOWN 
			or get_dir_left_arm() != Global.Direction.DOWN )
		):
		shoot.emit()
		pass
	
	if get_dir_right_arm() == Global.Direction.UP and get_dir_left_arm() == Global.Direction.UP:
		change_order.emit(Global.Order.FLY_HIGHER)
	elif get_dir_right_arm() == Global.Direction.RIGHT and get_dir_left_arm() == Global.Direction.DOWN:
		change_order.emit(Global.Order.FLY_RIGHT)
	elif get_dir_right_arm() == Global.Direction.DOWN and get_dir_left_arm() == Global.Direction.LEFT:
		change_order.emit(Global.Order.FLY_LEFT)
	else:
		change_order.emit(Global.Order.GLIDE)
			
	pass

func _physics_process(delta: float) -> void:
	
	if Global.selected_input_method == Global.InputMethod.KEYBOARD:
			# arms rotation
		if Input.is_action_pressed("brazo_der_rotar_der"):
			brazo_der.rotation += rotation_speed * delta
		if Input.is_action_pressed("brazo_der_rotar_izq"):
			brazo_der.rotation -= rotation_speed * delta
			
		if Input.is_action_pressed("brazo_izq_rotar_der"):
			brazo_izq.rotation += rotation_speed * delta
		if Input.is_action_pressed("brazo_izq_rotar_izq"):
			brazo_izq.rotation -= rotation_speed * delta
	
	else:
		# Get the direction vector for the left stick (Gamepad 0, axis 0 and 1)
		left_stick_vector = Input.get_vector("left_stick_left", "left_stick_right", "left_stick_up", "left_stick_down")

		# Get the direction vector for the right stick (Gamepad 0, axis 2 and 3)
		right_stick_vector = Input.get_vector("right_stick_left", "right_stick_right", "right_stick_up", "right_stick_down")
		
		 # If the stick is moved, calculate and apply the rotation
		if left_stick_vector.length() > 0:
			left_stick_angle = left_stick_vector.angle()
			brazo_izq.rotation = left_stick_angle + 90 # Apply the angle directly for immediate rotation
		
		if right_stick_vector.length() > 0:
			right_stick_angle = right_stick_vector.angle()
			brazo_der.rotation = right_stick_angle + 90
	
	# lantern turn on/off
	if Input.is_action_pressed("brazo_der_prender"):
		right_lantern_on = true
		brazo_der.get_node("linterna").prender()
	else:
		right_lantern_on = false
		brazo_der.get_node("linterna").apagar()
	if Input.is_action_pressed("brazo_izq_prender"):
		left_lantern_on = true
		brazo_izq.get_node("linterna").prender()
	else:
		left_lantern_on = false
		brazo_izq.get_node("linterna").apagar()	
	
	pass
	
func get_dir_right_arm() -> Global.Direction:
	var rotation:int = (int(brazo_der.rotation_degrees) %360 +360 )%360
	match true:
		_ when rotation > 20 and rotation <= 135:
			return Global.Direction.RIGHT
		_ when rotation > 135 and rotation <= 215:
			return Global.Direction.DOWN
		_ when rotation > 215 and rotation <= 295:
			return Global.Direction.LEFT
		_:
			return Global.Direction.UP
	
func get_dir_left_arm() -> Global.Direction:
	var rotation:int = (int(brazo_izq.rotation_degrees) %360 +360 )%360
	match true:
		_ when rotation > 65 and rotation <= 145:
			return Global.Direction.RIGHT
		_ when rotation > 145 and rotation <= 230:
			return Global.Direction.DOWN
		_ when rotation > 230 and rotation <= 340:
			return Global.Direction.LEFT
		_:
			return Global.Direction.UP
