extends Node3D

var cooldown = false


func _ready() -> void:
	new_tween()


func new_tween():
	await get_tree().create_timer(randf_range(0, 0.5)).timeout
	var tween = get_tree().create_tween()
	# get random position in circle
	var angle = randf_range(0, TAU) 
	var distance = sqrt(randf_range(0, 1)) * 10
	var random_offset = Vector2(distance, 0).rotated(angle)
	var new_pos = Vector3(random_offset.x, 7, random_offset.y)
	
	distance = (position - new_pos).length() # calculate distance so the tween moves at a constant speed
	
	tween.tween_property(self, "position", new_pos, distance / 8)
	tween.tween_callback(new_tween)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is RigidBody3D and not cooldown:
		cooldown = true
		body.freeze = false
		await get_tree().create_timer(1.0).timeout
		cooldown = false
	elif body is CharacterBody3D:
		get_node("/root/Main/CanvasLayer/HealthUI").remove_health(50) # deal initial damage
		$DamageTimer.start()
		if randi_range(1, 5) == 1 and not get_node("/root/Main/Voiceline").playing and not get_node("/root/Main/CanvasLayer/Dialog_UI").is_dialog_visible():
			get_node("/root/Main/Voiceline").stream = preload("res://voicelines/that tornado.ogg")
			get_node("/root/Main/Voiceline").play()
			get_node("/root/Main/CanvasLayer/Dialog_UI").show_dialog("That tornado is RIGHT on top of us.")
			await get_node("/root/Main/Voiceline").finished
			get_node("/root/Main/CanvasLayer/Dialog_UI").hide_dialog()


func _on_area_3d_body_exited(body: Node3D) -> void:
	$DamageTimer.stop()


func _on_damage_timer_timeout() -> void:
	get_node("/root/Main/CanvasLayer/HealthUI").remove_health(50)
