extends RigidBody3D


func _on_body_entered(body):
	if body is StaticBody3D or body is CharacterBody3D:
		freeze = true
		$MeshInstance3D.hide()
		$CollisionShape3D.set_deferred("disabled", true)
		$Target.hide()
		$Fire.emitting = false
		$Explosion.emitting = true
		
		for overlapping_body in $Target/Area3D.get_overlapping_bodies():
			if overlapping_body is CharacterBody3D:
				print("Hit player")
				get_node("/root/Main/Voiceline").play()
		
		await get_tree().create_timer(1.0).timeout
		queue_free()
