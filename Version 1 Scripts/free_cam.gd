extends Camera3D

@export var move_speed := 0.6
@export var mouse_sensitivity := 1

var yaw := 0.0
var pitch := 0.0
var mouse_delta := Vector2.ZERO
var mouse_lock := false
var camera_state := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_lock = true
	
	position = Vector3(0, 1, 0)

func _input(event: InputEvent) -> void:
	
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouse_lock = false
	
	elif event is InputEventMouseMotion and mouse_lock:
		mouse_delta += event.relative
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_pressed("change_camera"):
		camera_state += 1
	
	# Camera info for free cam
	if camera_state == 0:
		# Camera rotation stuff
		yaw -= mouse_delta.x * mouse_sensitivity * delta
		pitch -= mouse_delta.y * mouse_sensitivity * delta
		pitch = clamp(pitch, -PI/2.0, PI/2.0)
		mouse_delta = Vector2.ZERO
		rotation = Vector3(pitch, yaw, 0)
		
		# Camera movement stuff
		var move_delta := Vector3.ZERO
		var forward := Vector3(-sin(yaw), 0, -cos(yaw))
		var right := Vector3(cos(yaw), 0, -sin(yaw))
		
		if Input.is_action_pressed("move_forward"):
			move_delta += forward
		if Input.is_action_pressed("move_backwards"):
			move_delta -= forward
		if Input.is_action_pressed("move_right"):
			move_delta += right
		if Input.is_action_pressed("move_left"):
			move_delta -= right
		if Input.is_action_pressed("move_up"):
			move_delta.y += 1
		if Input.is_action_pressed("move_down"):
			move_delta.y -= 1

		position += move_delta * move_speed * delta
		move_delta = Vector3.ZERO	
	
	# Camera info for orbit cam
	if camera_state == 1:
		
		
		
		pass
	
	
	
	# Camera info for cockpit cam
	
	pass
