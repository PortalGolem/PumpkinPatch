extends CharacterBody3D


@export var SPEED:float = 5.0
@export var JUMP_VELOCITY:float = 4.5
@export var SENSITIVITY:float = 1.0
@export var MAX_LOOK_HEIGHT = 89
@export var MIN_LOOK_HEIGHT = -80

var cameraRotation:Vector2 = Vector2.ZERO

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	var cameraStartingRotation:Vector3 = $Camera3D.basis.get_euler()
	cameraRotation = Vector2(cameraStartingRotation.x, cameraStartingRotation.y)
	cameraRotation.x = clamp(cameraRotation.x, MIN_LOOK_HEIGHT, MAX_LOOK_HEIGHT)
	$Camera3D.basis = Basis.IDENTITY
	$Camera3D.rotate_x(deg_to_rad(cameraRotation.x))
	$Camera3D.rotate_y(deg_to_rad(cameraRotation.y))

func _input(event: InputEvent) -> void:
	# Handle mouse input.
	if event is InputEventMouseMotion:
		cameraRotation.x -= event.relative.y
		cameraRotation.y -= event.relative.x
		cameraRotation.x = clamp(cameraRotation.x, MIN_LOOK_HEIGHT, MAX_LOOK_HEIGHT)
		$Camera3D.basis = Basis.IDENTITY
		$Camera3D.rotate_x(deg_to_rad(cameraRotation.x))
		$Camera3D.rotate_y(deg_to_rad(cameraRotation.y))
		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	var direction:Vector3 = ($Camera3D.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
