extends CharacterBody3D

const SPEED = 5.5

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

func _physics_process(delta: float) -> void:
	var input_dir_2d = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var input_dir_3d = Vector3(input_dir_2d.x, 0.0, input_dir_2d.y)
	var direction = transform.basis * input_dir_3d
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	velocity.y -= 25.0 * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = 10.0
	elif Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y = 0.0
	
	move_and_slide()
	pass
