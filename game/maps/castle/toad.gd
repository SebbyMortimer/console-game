extends RigidBody3D


func _ready() -> void:
	if randi_range(1, 2) == 1:
		queue_free() # remove Toad half of the time bcs he's annoying


func _process(delta: float) -> void:
	if not sleeping and not $AudioStreamPlayer3D.playing:
		$AudioStreamPlayer3D.play()
