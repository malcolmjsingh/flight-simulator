extends MeshInstance3D

@export var freeMouseSensitivity := 1.0
@export var moveSpeed := 10
@export var mouse_delta := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	mesh = BoxMesh.new()
	
	
	pass # Replace with function body.

func _input(event) -> void:
	if event is InputEventMouseMotion:
		mouse_delta += event.relative

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
		# Camera rotation stuff
	
	# Camera movement stuff
	var move_delta := Vector3.ZERO
	var forward := Vector3(1, 0, 0)
	var right := Vector3(0, 0, 1)
	
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
	
	mouse_delta = Vector2.ZERO
	pass
