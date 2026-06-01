extends Node3D

var player_score = 0
var time_left = 100

func _ready() -> void:
	%TimeLeft.text = "Time left: " + str(time_left)
	%Player.player_died.connect(func on_player_died():
		get_tree().paused = true
		%VBoxContainer.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	)

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
	get_tree().paused = true
	%VBoxContainer.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass

func _on_back_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")
	pass # Replace with function body.


func _on_play_again_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene.call_deferred()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.
