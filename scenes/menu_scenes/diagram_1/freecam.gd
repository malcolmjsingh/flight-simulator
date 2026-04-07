extends Camera3D

@export var acceleration = 500.0
@export var moveSpeed = 500.0
@export var mouseSpeed = 500.0

var velocity  = Vector3.ZERO
var lookAngles = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lookAngles.y = clamp(lookAngles.y, PI/-2, PI/2)
	set_rotation(Vector3(lookAngles.y, lookAngles.x, 0))
	var direction = updateDirection()
	
	if direction.length_squared() > 0:
		velocity += direction * acceleration * delta
	if direction.length_squared() > moveSpeed:
		velocity = velocity.normalized() * moveSpeed
		
	translate(velocity * delta)

func _input(event):
	# mouse rotation
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.is_pressed():
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		lookAngles -= event.relative / mouseSpeed

		
func updateDirection():
	var dir = Vector3()
	if Input.is_action_pressed("pitch_up"):
		dir += Vector3.FORWARD
	if Input.is_action_pressed("pitch_down"):
		dir += Vector3.BACK
	if Input.is_action_pressed("roll_left"):
		dir += Vector3.LEFT
	if Input.is_action_pressed("roll_right"):
		dir += Vector3.RIGHT
	if Input.is_action_pressed("free_cam_up"):
		dir += Vector3.UP
	if Input.is_action_pressed("throttle_up"):
		dir += Vector3.DOWN
	if dir == Vector3.ZERO:
		velocity = Vector3.ZERO
		
	return dir.normalized()
