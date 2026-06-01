extends Control

func _ready() -> void:
	%OptionsPanel.visible = false

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")

func _on_options_pressed() -> void:
	%MainMenu.visible = false
	%OptionsPanel.visible = true
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	%OptionsPanel.visible = false
	%MainMenu.visible = true
	pass # Replace with function body.
