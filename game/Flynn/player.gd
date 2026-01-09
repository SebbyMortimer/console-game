extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 10
var push_force = 1.0

var is_jumping = false # variable used to stop walk and idle anims overriding the jump anim

@onready var cameraRotatePoint = $CameraRotatePoint


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta: float) -> void:
	cameraRotatePoint.position = position + Vector3(0, 1.5, 0)
	# manually update position as I enabled top level to disconnect from the players rotation


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		is_jumping = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimationPlayer.play("Jump")
		is_jumping = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = Vector3(input_dir.x, 0, input_dir.y).rotated(Vector3.UP, cameraRotatePoint.rotation.y).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), 0.1)
		
		if not is_jumping:
			$AnimationPlayer.play("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		if not is_jumping:
			$AnimationPlayer.play("Idle")
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody3D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_delta = event.relative
		
		var camRotation = cameraRotatePoint.rotation_degrees - Vector3(mouse_delta.y / 10, mouse_delta.x / 10, 0)
		camRotation.x = clampf(camRotation.x, -80, 80)
		cameraRotatePoint.rotation_degrees = camRotation
