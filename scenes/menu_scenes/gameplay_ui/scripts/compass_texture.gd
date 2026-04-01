extends TextureRect

@export var textureWidth := 0

# Called when the node enters the scene tree for the first time.

func _on_do_something() -> void:
	print("signal test")

func _ready() -> void:
	
	
	var cameraScene = get_parent().get_node("OrbitCam/OrbitFollow")
	
	print(cameraScene)
	
	pass # Replace with function body.
	pass

func setTexturePosition(offset):	
	var degrees = rad_to_deg(offset.y)
	degrees = fmod(degrees, 360.0)
	
	var x_offset = (degrees / 360.0) * textureWidth + textureWidth
	position.x = -x_offset

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	
	pass
