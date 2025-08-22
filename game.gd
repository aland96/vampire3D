extends Node3D

var player_score = 0

func increase_score():
	player_score += 1
	%Label.text = "Score: " + str(player_score)
	pass

func _on_mob_spawner_3d_mob_spawned(mob: Variant) -> void:
	mob.mob_died.connect(increase_score)
	pass
