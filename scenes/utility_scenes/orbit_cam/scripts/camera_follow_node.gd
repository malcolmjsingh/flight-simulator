extends Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	"""
	This keeps the camera rotation independent to the vehicle rotation, despite it being parented to the vehicle.
	There is probably another way to do it, but this is easier and therefore better.
	"""
	global_rotation = Vector3.ZERO
