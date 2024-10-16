class_name Airplane
extends Area2D

@export var movement_speed:float = 35.0
@export var glide_speed:float = 30.0
@export var bullet_scene: PackedScene
@export var supplies_scene: PackedScene
@onready var marshall = get_node("../marshall")
@onready var health_bar = get_node("../CanvasLayer/UI/HBoxContainer/HealthBar")
@onready var screen_size = get_viewport_rect().size  
@onready var shoot_timer: Timer = $ShootTimer
@onready var supplies_timer: Timer = $SuppliesTimer
@onready var marker_2d: Marker2D = $Marker2D
@onready var sfx_airplane_take_damage: AudioStreamPlayer = $SFX_AirplaneTakeDamage
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var sprite_2d: Sprite2D = $Sprite2D


var blink_duration: float = 0.1
var blink_times: int = 5
var can_take_damage: bool = true

var can_drop_supllies = true
var can_shoot = true
var current_order: Global.Order = Global.Order.GLIDE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cpu_particles_2d.finished.connect(remove_airplane)
	pass # Replace with function body.

func remove_airplane():
	Global.sfx_game_over.play()
	get_tree().change_scene_to_file("res://scenes/Menus/game_over_menu.tscn")
	#queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# baja a velocidad constante
	if current_order == Global.Order.FLY_HIGHER:
		position.y -= movement_speed * delta
	elif current_order == Global.Order.FLY_RIGHT:
		position.x += movement_speed * delta
	elif current_order == Global.Order.FLY_LEFT:
		position.x -= movement_speed * delta
	
	if current_order != Global.Order.FLY_HIGHER :
		position.y += glide_speed * delta
		
	# Avoid the plane moving off-screen
	position.x = clamp(position.x, sprite_width()/2, screen_size.x - sprite_width()*0.5)
	position.y = clamp(position.y, sprite_height()/2, screen_size.y + 3*sprite_height())
	pass

func _on_marshall_shoot() -> void:
	if can_shoot:
		print_debug("DISPARAR")
		var bullet : PlayerBullet = bullet_scene.instantiate()
		get_tree().root.add_child.call_deferred(bullet)
		bullet.global_position = $Marker2D.global_position
		
		can_shoot = false
		shoot_timer.start()
	pass # Replace with function body.


func _on_marshall_drop_supplies() -> void:
	if can_drop_supllies:
		var supplies_instance = preload("res://scenes/supplies.tscn").instantiate()
		
		var airplane_position = position
		supplies_instance.position = Vector2(airplane_position.x, airplane_position.y + sprite_height()/2 )
		
		get_parent().add_child(supplies_instance)
		
		supplies_instance.connect("supplies_delivered", Callable(Global.island, "_on_supplies_received"))
		can_drop_supllies = false
		supplies_timer.start()
	pass # Replace with function body.


func _on_marshall_fly_higher() -> void:
	pass # Replace with function body.


func _on_marshall_change_order(new_order: int) -> void:
	current_order = new_order
	pass # Replace with function body.

func sprite_width():
	if sprite_2d.texture:
		var texture_size = sprite_2d.texture.get_size()
		var scaled_width = texture_size.x * sprite_2d.scale.x
		return scaled_width
	else:
		return 0.0

	
func sprite_height() -> float:
	if sprite_2d.texture:
		var texture_size = sprite_2d.texture.get_size()
		var scaled_height = texture_size.y * sprite_2d.scale.y
		return scaled_height
	else:
		return 0.0


func _on_supplies_timer_timeout() -> void:
	can_drop_supllies = true
	pass # Replace with function body.


func _on_shoot_timer_timeout() -> void:
	can_shoot = true
	pass # Replace with function body.
	
func take_damage() -> void:
	if can_take_damage:
		sfx_airplane_take_damage.play()
		can_take_damage = false
		health_bar.value -= 1
		#TODO sacar a Game Manager
		if health_bar.value == 0:
			Global.sfx_enemy_explode.play()
			sprite_2d.visible = false
			cpu_particles_2d.emitting = true
			return
		blink() 
		
	pass
	
func blink():
	# Start the blinking effect
	var blink_effect := blink_times * 2  # Multiply by 2 (on and off per cycle)
	for i in range(blink_effect):
		if i % 2 == 0:
			modulate = Color(1, 1, 1, 0)  # Transparent (off)
		else:
			modulate = Color(1, 1, 1, 1)  # Visible (on)
		await get_tree().create_timer(blink_duration).timeout
	modulate = Color(1, 1, 1, 1)  # Ensure node is fully visible after blinking
	can_take_damage = true


func _on_area_entered(area: Area2D) -> void:
	print_debug("SOMETHING ENTERED IN THE AREA")
	if area.is_in_group("enemies"):
		print_debug("IT'S AN ENEMY")
		var enemy: Enemy = area as Enemy
		take_damage()
		enemy.take_damage()
	pass # Replace with function body.


func _on_sea_area_entered(area: Area2D) -> void:
	health_bar.value = 0
	take_damage()
	pass # Replace with function body.
