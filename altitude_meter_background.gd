extends TextureRect

@export var targetPlayer : MeshInstance3D
@export var textureHeight := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var altitude = targetPlayer.global_position.y
	
	position.y = fmod(altitude, 1000.0 * 0.25) - 1000.0 * 0.25
	
	# print(position.y)
	
	
