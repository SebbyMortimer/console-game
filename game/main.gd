extends Node3D

@export var meteor: PackedScene = preload("res://meteor/meteor.tscn")
var roundFinished = false

func _ready() -> void:
	$RoundTimer.start()
	meteor_shower()


func meteor_shower():
	while not roundFinished:
		var new_meteor = meteor.instantiate()
		
		# get random position in circle
		var angle = randf_range(0, TAU) 
		var distance = sqrt(randf_range(0, 1)) * 10
		var random_offset = Vector2(distance, 0).rotated(angle)
		
		new_meteor.position = Vector3(random_offset.x, 10, random_offset.y)
		new_meteor.find_child("Target").position = Vector3(random_offset.x, 1.01, random_offset.y)
		new_meteor.body_entered.connect(new_meteor._on_body_entered)
		
		add_child(new_meteor)
		await get_tree().create_timer(0.1).timeout


func _on_round_timer_timeout() -> void:
	roundFinished = true
	print("Round ended")
