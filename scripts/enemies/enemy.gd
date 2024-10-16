class_name Enemy
extends Area2D

var enemy_resource: EnemyResource
var enemy_health: int
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready():
	
	var max_y_pos = 2 * get_viewport().get_visible_rect().size.y / 3
	var y_starting_position = randi_range(100, max_y_pos)
	position.y = y_starting_position

	# se posiciona fuera de pantalla, del lado derecho
	position.x = get_viewport().get_visible_rect().size.x + 100
	scale = Vector2(0.45, 0.45)
	
	enemy_health = enemy_resource.health
	#print_debug("Enemy ready")
	
	cpu_particles_2d.finished.connect(remove_enemy)
	add_to_group("enemies")

	match enemy_resource.movement_type:
		enemy_resource.MovementType.BASIC:
			add_child(preload("res://scenes/Behaviors/Movement/movement_basic.tscn").instantiate())
			pass
		enemy_resource.MovementType.UP_AND_DOWN:
			add_child(preload("res://scenes/Behaviors/Movement/movement_basic.tscn").instantiate())
			add_child(preload("res://scenes/Behaviors/Movement/movement_up_and_down.tscn").instantiate())
			pass
		enemy_resource.MovementType.FAST:
			add_child(preload("res://scenes/Behaviors/Movement/movement_fast.tscn").instantiate())
			pass

	pass
	
func remove_enemy():
		queue_free()

func take_damage():
	Global.sfx_enemy_take_damage.play()
	enemy_health -= 1
	if enemy_health == 0:
		Global.sfx_enemy_explode.play()
		sprite_2d.visible = false
		cpu_particles_2d.emitting = true
		await get_tree().create_timer(1).timeout
		
	print_debug("enemy hit")
	pass
