extends Control

@onready var main = $"../../"
@onready var label: Label = $VBoxContainer/Label
@onready var try_again: Button = $VBoxContainer/TryAgain
@onready var texture_rect: TextureRect = $TextureRect

func _ready() -> void:
	if Global.game_won:
		label.text = "YOU DID IT!"
		try_again.text = "PLAY AGAIN"
	else:
		texture_rect.texture = load("res://assets/background/game_over_lose.jpg")
		
	pass

func _on_quit_pressed() -> void:
	Global.sfx_button_change_scene.play()
	get_tree().change_scene_to_file("res://scenes/Menus/menu.tscn")
	pass

func _on_quit_mouse_entered() -> void:
	Global.sfx_button_hover.play()
	pass # Replace with function body.


func _on_try_again_pressed() -> void:
	Global.sfx_game_start.play()
	Global.reset_game()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	pass # Replace with function body.


func _on_try_again_mouse_entered() -> void:
	Global.sfx_button_hover.play()
	pass # Replace with function body.
