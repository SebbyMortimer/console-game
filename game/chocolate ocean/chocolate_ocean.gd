extends StaticBody3D

@export var bubble: PackedScene = preload("res://chocolate ocean/bubble.tscn")

func _on_bubble_timer_timeout() -> void:
	var new_bubble = bubble.instantiate()
	new_bubble.position = Vector3(randf_range(-25, 25), 0, randf_range(-25, 25))
	add_child(new_bubble)
	
	$BubbleTimer.start(randf_range(0, 0.5))
	await get_tree().create_timer(2.0).timeout
	new_bubble.queue_free()
