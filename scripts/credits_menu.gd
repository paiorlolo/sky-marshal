extends Control

func _ready():

	pass

func _on_back_pressed() -> void:
	Global.sfx_button_change_scene.play()
	get_tree().change_scene_to_file("res://scenes/Menus/menu.tscn")
	pass # Replace with function body.


func _on_back_mouse_entered() -> void:
	Global.sfx_button_hover.play()
	pass # Replace with function body.
