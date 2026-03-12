extends GPUParticles3D

@export var raining := false
@export var rainDensity := 1
@export var targetPlayer : MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#emitting = raining
	#amount = int(400 * rainDensity)

	#position = targetPlayer.global_position
	
	#if raining:
	#	$"../HDRI".environment.background_energy_multiplier = 0.5
	#else:
	#	$"../HDRI".environment.background_energy_multiplier = 1.0
