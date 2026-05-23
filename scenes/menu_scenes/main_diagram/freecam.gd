## This is a camera that flies around and lets the user explore the Airport\

extends Camera3D

# These give a value to the camera's acceleration and it's initial velocity
@export var acceleration = 200.0
@export var moveSpeed = 200.0
@export var mouseSpeed = 200.0

# These track the camera's speed, direction of movement, and rotation
var velocity  = Vector3.ZERO
var lookAngles = Vector2.ZERO

# This captures the users mouse and locks it into a first person mouse-pointer camera
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
# Makes sure you cannot flip the camera upside down, then applies rotation
func _process(delta: float) -> void:
	lookAngles.y = clamp(lookAngles.y, PI/-2, PI/2)
	set_rotation(Vector3(lookAngles.y, lookAngles.x, 0))
	var direction = updateDirection()
	
	# This will accelerate the camera in the direction that the mouse is pointing in
	if direction.length_squared() > 0:
		velocity += direction * acceleration * delta
	# Makes sure camera doesn't accelerate forever
	if direction.length_squared() > moveSpeed:
		velocity = velocity.normalized() * moveSpeed
	
	# Moves camera	
	translate(velocity * delta)

func _input(event):
	# This checks if the user clicked right click, and locks/unlocks accordingly
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.is_pressed():
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Rotates camera based on how far mouse moved
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		lookAngles -= event.relative / mouseSpeed
		
func updateDirection():
	# This detects whether W, A, S, D, Shift, or Space was clicked, and moves in that direction
	var dir = Vector3()
	if Input.is_action_pressed("move_forward"):
		dir += Vector3.FORWARD
	if Input.is_action_pressed("move_backward"):
		dir += Vector3.BACK
	if Input.is_action_pressed("move_left"):
		dir += Vector3.LEFT
	if Input.is_action_pressed("move_right"):
		dir += Vector3.RIGHT
	if Input.is_action_pressed("move_up"):
		dir += Vector3.UP
	if Input.is_action_pressed("move_down"):
		dir += Vector3.DOWN
	if dir == Vector3.ZERO:
		velocity = Vector3.ZERO
		
	# Keeps diagonal movement the same speed as straight movement
	return dir.normalized()
