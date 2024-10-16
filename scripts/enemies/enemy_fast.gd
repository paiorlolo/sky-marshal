class_name EnemyFast
extends Enemy

func _ready():
	enemy_resource = load("res://scripts/enemies/resources_enemy/fast.tres")
	super()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.
