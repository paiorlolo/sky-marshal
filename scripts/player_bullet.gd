class_name PlayerBullet
extends Area2D

@export var speed: float = 300
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	position.x += speed * delta
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.


func _on_area_entered(area: Area2D) -> void:
	var enemy: Enemy = area as Enemy
	enemy.take_damage()
	queue_free()
	pass # Replace with function body.
