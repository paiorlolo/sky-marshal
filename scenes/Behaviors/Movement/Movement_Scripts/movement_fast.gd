extends MovementBehaviorNode

@onready var speed: float = get_parent().enemy_resource.speed
@onready var stopped: bool = false
@onready var waiting: bool = false
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
var original_speed: float


func _ready():
	original_speed = speed

func _physics_process(delta: float) -> void:
	if stopped:
		return
	else: 
		get_parent().global_position.x -= speed * delta
	
	if (not waiting and get_parent().global_position.x < get_viewport().get_visible_rect().size.x - 200):
		stop_and_wait() 
		
	pass

func stop_and_wait():
	stopped = true
	waiting = true
	# Creamos un temporizador que ejecutará la función 'resume_movement' después de 3 segundos
	var timer = get_tree().create_timer(3.0)
	await timer.timeout
	resume_movement()
	
func resume_movement():
	stopped = false
	audio_stream_player.play()
	speed = 10 * original_speed
