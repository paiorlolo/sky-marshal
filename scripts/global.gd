extends Node

@onready var sfx_button_change_scene: AudioStreamPlayer = $sfx_button_change_scene
@onready var sfx_button_hover: AudioStreamPlayer = $sfx_button_hover
@onready var sfx_game_start: AudioStreamPlayer = $sfx_game_start
@onready var sfx_enemy_take_damage: AudioStreamPlayer = $sfx_enemy_take_damage
@onready var sfx_enemy_explode: AudioStreamPlayer = $sfx_enemy_explode
@onready var sfx_game_won: AudioStreamPlayer = $sfx_game_won
@onready var sfx_game_over: AudioStreamPlayer = $sfx_game_over

var game_won = false
var island: Island
var selected_input_method: InputMethod
var supplies_delivered: int = 0

enum Direction { 
	UP, 
	RIGHT,
	DOWN,
	LEFT,
}

enum InputMethod { 
	KEYBOARD,
	GAMEPAD,
}

enum Order{
	GLIDE,
	FLY_HIGHER,
	FLY_RIGHT,
	FLY_LEFT,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), linear_to_db(0.25))
	selected_input_method = InputMethod.KEYBOARD
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func receive_supply() -> void:
	supplies_delivered += 1
	pass

func mark_game_as_won() -> void:
	supplies_delivered = 0
	game_won = true
	pass
	
func reset_game() -> void:
	supplies_delivered = 0
	game_won = false
	pass

func supplies_received() -> void:
	pass
