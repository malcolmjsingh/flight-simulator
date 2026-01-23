extends Camera3D

@export var moveSpeed := 0.6
@export var freeMouseSensitivity := 1
@export var orbitMouseSensitivity := 0.5
@export var orbitPivot : Node3D
@export var orbitZoomSensitivity := 0.01
@export var orbitMinZoom := 1.0
@export var orbitMaxZoom := 10.0


var mouse_delta := Vector2.ZERO
var mouse_lock := false
var camera_state := 0
var orbit_zoom := 3.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_lock = true
	position = Vector3(0, 1, 0)

func _input(event: InputEvent) -> void:
	# Checking button inputs
	if event is InputEventKey and event.pressed:
		# Unlock mouse for pause menu
		if event.keycode == KEY_ESCAPE:
			if mouse_lock:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				mouse_lock = false
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				mouse_lock = true
		
		# Changing camera
		if Input.is_action_just_pressed("changeCamera"):
			camera_state += 1
			camera_state %= 2
			
			if camera_state == 0: # Free cam
				print(global_rotation)
				var t: Transform3D = global_transform
				set_as_top_level(true)
				global_transform = t
			
			elif camera_state == 1: # Orbit cam
				set_as_top_level(false)
				position = Vector3(0, 0, -orbit_zoom)
				rotation = Vector3(PI, 0, PI)
				
			elif camera_state == 2: # Cockpit cam
				pass
	
	# Mouse movement handling
	elif event is InputEventMouseMotion and mouse_lock:
		mouse_delta += event.relative

func freeCameraUpdate(delta: float) -> void:
	"""
	This function handles free camera update along with movement for all axises while in free camera mode.
	
	Args:
	- delta (float) : Amount of time passed between calls
	
	Returns:
	- None 
	"""
	
	# Camera rotation stuff
	rotation.x -= clamp(mouse_delta.y * freeMouseSensitivity * delta, -PI/2.0, PI/2.0)
	rotation.y -= mouse_delta.x * freeMouseSensitivity * delta
	
	# Camera movement stuff
	var move_delta := Vector3.ZERO
	var forward := Vector3(-sin(rotation.y), 0, -cos(rotation.y))
	var right := Vector3(cos(rotation.y), 0, -sin(rotation.y))
	
	if Input.is_action_pressed("moveForward"):
		move_delta += forward
	if Input.is_action_pressed("moveBackwards"):
		move_delta -= forward
	if Input.is_action_pressed("moveRight"):
		move_delta += right
	if Input.is_action_pressed("moveLeft"):
		move_delta -= right
	if Input.is_action_pressed("moveUp"):
		move_delta.y += 1
	if Input.is_action_pressed("moveDown"):
		move_delta.y -= 1

	position += move_delta * moveSpeed * delta
	move_delta = Vector3.ZERO
	
func orbitCameraUpdate(delta: float):
	"""
	This function handles the orbit camera update.
	
	Args:
	- delta (float) : Amount of time passed between calls
	
	Returns:
	- None 
	"""
	var radialDistanceX = mouse_delta.x * orbitMouseSensitivity * delta
	var radialDistanceY = mouse_delta.y * orbitMouseSensitivity * delta
	orbitPivot.updateRotation(radialDistanceX, radialDistanceY)
	if Input.is_action_pressed("orbitZoomIn"):
		orbit_zoom -= orbitZoomSensitivity
		orbit_zoom = clamp(orbit_zoom, orbitMinZoom, orbitMaxZoom)
		position = Vector3(0, 0, -orbit_zoom)
	elif Input.is_action_pressed("orbitZoomOut"):
		orbit_zoom += orbitZoomSensitivity
		orbit_zoom = clamp(orbit_zoom, orbitMinZoom, orbitMaxZoom)
		position = Vector3(0, 0, -orbit_zoom)
	
func cockpitCameraUpdate(delta: float):
	"""
	This function is under development. Please do not use it.
	"""
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Camera info for free cam
	if camera_state == 0:
		freeCameraUpdate(delta)
	# Camera info for orbit cam
	if camera_state == 1:
		orbitCameraUpdate(delta)
		
	if camera_state == 2:
		cockpitCameraUpdate(delta)
	
	mouse_delta = Vector2.ZERO
