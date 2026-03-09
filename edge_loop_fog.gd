extends FogVolume

@export var loopOn := true
@export var targetPlayer : MeshInstance3D
@export var minDistance := 90.0
@export var maxDistance := 150.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if loopOn:
		position = targetPlayer.global_position
		
		var distance_magnitude =  sqrt(position.x**2 + position.z**2)
		
		if distance_magnitude > minDistance: 
			var fog_curve = abs(((maxDistance - minDistance) - (distance_magnitude - minDistance)) / (maxDistance - minDistance)) / 5.0
			material.density = clamp(fog_curve, 0, 2)
		else:
			material.density = 0
