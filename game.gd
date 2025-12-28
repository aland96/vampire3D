extends Node3D

var player_score = 0
var time_left = 100

func _ready() -> void:
	%TimeLeft.text = "Time left: " + str(time_left)

func increase_score():
	player_score += 1
	%Label.text = "Score: " + str(player_score)
	pass

func decrease_time():
	time_left -= 1
	%TimeLeft.text = "Time left: " + str(time_left)
	if time_left == 0:
		get_tree().paused = true
		%WonLabel.visible = true

func spawn_poof(mob_position):
	const smoke_puff = preload("res://mob/smoke_puff/smoke_puff.tscn")
	var poof = smoke_puff.instantiate()
	add_child(poof)
	poof.global_position = mob_position

func _on_mob_spawner_3d_mob_spawned(mob: Variant) -> void:
	mob.mob_died.connect(func on_mob_died():
		increase_score()
		spawn_poof(mob.global_position)
	)
	spawn_poof(mob.global_position)
	pass

func _on_kill_plane_body_entered(body: Node3D) -> void:
	get_tree().reload_current_scene.call_deferred()
	pass
