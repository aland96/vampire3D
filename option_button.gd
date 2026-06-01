extends OptionButton

var options = [1, 0.75, 0.5]

func _on_item_selected(index: int) -> void:
	var value = options[index]
	get_tree().root.scaling_3d_scale = value
