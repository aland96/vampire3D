extends CharacterBody3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.4
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.25
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x, -70.0, 70.0)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass
