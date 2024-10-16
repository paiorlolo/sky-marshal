extends Control

@onready var main = $"../../"


func _on_resume_pressed() -> void:
	Global.sfx_game_start.play()
	main.pause_menu()
	pass # Replace with function body.


func _on_main_menu_pressed() -> void:
	Global.sfx_button_change_scene.play()
	main.pause_menu()
	get_tree().change_scene_to_file("res://scenes/Menus/menu.tscn")
	pass # Replace with function body.


func _on_resume_mouse_entered() -> void:
	Global.sfx_button_hover.play()
	pass # Replace with function body.
	

func _on_main_menu_mouse_entered() -> void:
	Global.sfx_button_hover.play()
	pass # Replace with function body.
