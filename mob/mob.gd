extends RigidBody3D

signal mob_died()

var health = 3.0
var speed = randf_range(2.0, 4.0)

@onready var bat_model: Node3D = %bat_model
@onready var hurt_sound: AudioStreamPlayer3D = %HurtSound
@onready var ko_sound: AudioStreamPlayer3D = %KOSound
@onready var player = get_node("/root/Game/Player")

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	direction.y = 0.0
	linear_velocity = direction * speed
	bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI
	pass

func take_damage():
	if health == 0:
		return
	
	bat_model.hurt()
	hurt_sound.play()	
	health -= 1
	
	if health == 0:
		set_physics_process(false)
		gravity_scale = 1.0
		var direction = -1.0 * global_position.direction_to(player.global_position)
		var force = Vector3.UP * randf_range(1.0, 5.0)
		apply_central_impulse(direction * 10.0 + force)
		%Timer.start()
		lock_rotation = false
		mob_died.emit()
		ko_sound.play()
	pass


func _on_timer_timeout() -> void:
	queue_free()
	pass
