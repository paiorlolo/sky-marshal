class_name GameManager
extends Node2D

@export var clouds_spawining_time: int = 15
@export var enemies_spawining_time: int = 5
@export var enemies_in_level: Array [PackedScene] = [] 
@export var supplies_goal: int = 3
@onready var clouds_timer: Timer = $CloudSpawnTimer
@onready var enemies_timer: Timer = $EnemiesSpawnTimer
@onready var lbl_current_supplies: Label = $CanvasLayer/UI/lbl_current_supplies
@onready var pause_menu_scene: Control = $CanvasLayer2/PauseMenu
var paused = false

func _ready():
	clouds_timer.start()
	enemies_timer.start()
	lbl_current_supplies.text = "%d / %d Supplies Delivered" % [Global.supplies_delivered, supplies_goal]
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_menu()
	pass;

func _physics_process(delta: float) -> void:
	pass;


func spawn_enemy() -> void:
	var enemy_instance = enemies_in_level.pick_random().instantiate()
	add_child(enemy_instance)
	pass
	
func spawn_island() -> void:
	var island_instance = preload("res://scenes/island.tscn").instantiate()
	add_child(island_instance)
	Global.island = island_instance
	pass


func spawn_cloud() -> void:
	var cloud: Cloud = preload("res://scenes/cloud.tscn").instantiate()
	add_child(cloud)
	clouds_timer.wait_time = randf_range(5, clouds_spawining_time)
	clouds_timer.start()
	pass 


func _on_cloud_spawn_timer_timeout() -> void:
	spawn_cloud()
	if (not has_node("Island")):
		spawn_island()
		
	pass

func pause_menu():
	if paused: 
		pause_menu_scene.hide()
		Engine.time_scale = 1
	else:
		pause_menu_scene.show()
		Engine.time_scale = 0
	
	paused = !paused


func _on_enemies_spawn_timer_timeout() -> void:
	spawn_enemy()
	enemies_timer.wait_time = randf_range(1, enemies_spawining_time)
	enemies_timer.start()
	pass # Replace with function body.
