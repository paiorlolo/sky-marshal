extends Control

func _on_play_pressed() -> void:
	Global.sfx_game_start.play()
	Global.reset_game()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	pass 


func _on_options_pressed() -> void:
	Global.sfx_button_change_scene.play()
	get_tree().change_scene_to_file("res://scenes/Menus/options_menu.tscn")
	pass 


func _on_credits_pressed() -> void:
	Global.sfx_button_change_scene.play()
	get_tree().change_scene_to_file("res://scenes/Menus/credits_menu.tscn")
	pass 


func _on_quit_pressed() -> void:
	get_tree().quit()
	pass


func _on_play_mouse_entered() -> void:
	Global.sfx_button_hover.play()
	pass # Replace with function body.


func _on_options_mouse_entered() -> void:
	Global.sfx_button_hover.play()
	pass # Replace with function body.


func _on_credits_mouse_entered() -> void:
	Global.sfx_button_hover.play()
	pass # Replace with function body.


func _on_quit_mouse_entered() -> void:
	Global.sfx_button_hover.play()
	pass # Replace with function body.
