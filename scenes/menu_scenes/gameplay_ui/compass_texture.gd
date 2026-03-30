extends TextureRect

@export var camera: Camera3D
@export var cameraPivot: Node3D
@export var textureWidth := 1600

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
	#var cameraYaw = 0
	#if camera.camera_state == 0:
		#cameraYaw = camera.rotation.y
	#elif camera.camera_state == 1:
		#cameraYaw = cameraPivot.rotation.y
	#
	#var degrees = rad_to_deg(cameraYaw)
	#degrees = fmod(degrees, 360.0)
	#
	#var x_offset = (degrees / 360.0) * textureWidth + textureWidth
	#
	#position.x = -x_offset
	#
