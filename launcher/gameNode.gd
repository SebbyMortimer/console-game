extends TextureButton


func _on_focus_entered() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.1)
	z_index = 1
	$GameName.visible = true


func _on_focus_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.1)
	z_index = 0
	$GameName.visible = false
