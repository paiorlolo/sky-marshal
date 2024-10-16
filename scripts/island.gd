class_name Island
extends Area2D

#var speed: float = randf_range(10, 20)
var speed: float = 50
var box_received: bool = false
var island_visited = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var main_node = get_parent()
@onready var label: Label = main_node.get_node("CanvasLayer/UI/lbl_current_supplies")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#position.y = DisplayServer.window_get_size().y 
	position.y = get_viewport().get_visible_rect().size.y
	print_debug(main_node)
	print_debug(label)
	# se posiciona fuera de pantalla, del lado derecho
	#position.x = DisplayServer.window_get_size().x + 100
	position.x = get_viewport().get_visible_rect().size.x + 100
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if box_received and not island_visited:
		animation_player.play("delivered")
		Global.receive_supply()
		var supplies_goal = main_node.supplies_goal
		label.text = "%d / %d Supplies Delivered" % [Global.supplies_delivered, supplies_goal]
		
		#TODO sacar a Game Manager
		if Global.supplies_delivered == supplies_goal:
			Global.sfx_game_won.play()
			Global.game_won = true
			get_tree().change_scene_to_file("res://scenes/Menus/game_over_menu.tscn")
			return
			
		island_visited = true
	pass
	
func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.
	
func _on_supplies_received() -> void:
	box_received = true
	pass
