class_name Supplies
extends Area2D

@onready var sfx_supplies_dropped: AudioStreamPlayer = $SFX_SuppliesDropped
@export var speed:float = 20.0
signal supplies_delivered

func _ready():
	sfx_supplies_dropped.play()
	supplies_delivered.connect(Global.supplies_received)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	position.y += speed * delta

	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("island"):
		# Handle collision with the island
		print_debug("Supply box hit the island!")
		emit_signal("supplies_delivered")
		queue_free()
	pass # Replace with function body.
