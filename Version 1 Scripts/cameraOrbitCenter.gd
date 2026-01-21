extends Node3D

@export var targetObject : MeshInstance3D
var orbitEnable := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func updateRotation(deltaX:float, deltaY:float) -> void:
	"""
	This function updates the rotation of the orbit camera center.
	
	Args:
	- deltaX (float) : Movement of mouse in x direction
	- deltaY (float) : Movement of mouse in y direction
	
	Returns:
	 - None
	"""
	rotation -= Vector3(-deltaY, deltaX, 0)

func updatePosition(target) -> void:
	"""
	This function centers the orbit camera around an object.
	
	Args:
	- target (Mesh3D) : Object to orbit
	
	Returns:
	- None
	"""
	position = target.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	updatePosition(targetObject)
