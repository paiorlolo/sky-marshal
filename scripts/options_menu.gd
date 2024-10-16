extends Control

@onready var master_slider: HSlider = $VBoxContainer/Master/MasterSlider
@onready var sfx_slider: HSlider = $VBoxContainer/SFX/SFXSlider
@onready var music_slider: HSlider = $VBoxContainer/Music/MusicSlider
@onready var keyboard_check_button: CheckButton = $VBoxContainer/Input/KeyboardVBoxContainer/KeyboardCheckButton
@onready var gamepad_check_button: CheckButton = $VBoxContainer/Input/GamepadVBoxContainer/GamepadCheckButton


var master_bus_index: int
var sfx_bus_index: int
var music_bus_index: int

func _ready():
	master_bus_index= AudioServer.get_bus_index("Master")
	sfx_bus_index = AudioServer.get_bus_index("sfx")
	music_bus_index = AudioServer.get_bus_index("music")
	
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus_index))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_index))
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus_index))
	
	if Global.selected_input_method == Global.InputMethod.KEYBOARD:
		keyboard_check_button.button_pressed = true
	else:
		gamepad_check_button.button_pressed = true
		
	pass

func _on_back_pressed() -> void:
	Global.sfx_button_change_scene.play()
	get_tree().change_scene_to_file("res://scenes/Menus/menu.tscn")
	pass # Replace with function body.


func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(value))
	pass # Replace with function body.


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(value))
	pass # Replace with function body.


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(value))
	pass # Replace with function body.


func _on_back_mouse_entered() -> void:
	Global.sfx_button_hover.play()
	pass # Replace with function body.


func _on_keyboard_check_button_pressed() -> void:
	Global.sfx_button_hover.play()
	Global.selected_input_method = Global.InputMethod.KEYBOARD
	pass # Replace with function body.


func _on_gamepad_check_button_pressed() -> void:
	Global.sfx_button_hover.play()
	Global.selected_input_method = Global.InputMethod.GAMEPAD
	pass # Replace with function body.
