extends Node3D

@export var ball: PackedScene = preload("res://ball/ball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_round_timer_timeout() -> void:
	var new_ball = ball.instantiate()
	
	var randX = randf_range(-10, 10)
	var randZ = randf_range(-10, 10)
	
	new_ball.position = Vector3(randX, 10, randZ)
	new_ball.find_child("Target").position = Vector3(randX, 1.01, randZ)
	new_ball.body_entered.connect(new_ball._on_body_entered)
	
	add_child(new_ball)
