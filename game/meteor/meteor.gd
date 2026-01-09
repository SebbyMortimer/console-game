extends RigidBody3D


func _on_body_entered(body):
	if body is StaticBody3D or body is RigidBody3D or body is CharacterBody3D: # if it hits the ground, ocean, destructible or the player
		freeze = true
		$MeshInstance3D.hide()
		$CollisionShape3D.set_deferred("disabled", true)
		$Target.hide()
		$Fire.emitting = false
		$Explosion.emitting = true
		
		for overlapping_body in $Target/Area3D.get_overlapping_bodies():
			if overlapping_body is CharacterBody3D:
				get_node("/root/Main/CanvasLayer/HealthUI").remove_health(100)
				if randi_range(1, 5) == 1 and not get_node("/root/Main/Voiceline").playing and not get_node("/root/Main/CanvasLayer/Dialog_UI").is_dialog_visible(): # random chance
					get_node("/root/Main/Voiceline").stream = preload("res://voicelines/hey watch it.ogg")
					get_node("/root/Main/Voiceline").play()
					get_node("/root/Main/CanvasLayer/Dialog_UI").show_dialog("Hey, watch it! Look I didn't get to be this handsome by getting hit with bombs!")
					get_node("/root/Main/Voiceline").finished.connect(get_node("/root/Main/CanvasLayer/Dialog_UI").hide_dialog)
			elif overlapping_body is RigidBody3D: # if it's in the blast radius, unfreeze the body
				overlapping_body.freeze = false
		
		await get_tree().create_timer(1.0).timeout
		queue_free()
