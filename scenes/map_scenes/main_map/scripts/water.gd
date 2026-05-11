extends Node3D

@export var count := 50
@export var water_mesh : MeshInstance3D
@export var water_size := 20.0
@export var water_level := -100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	"""
	When loaded, the water will create a 50 x 50 grid of water tiles automatically. This is to circiumvent the extremely laborious and boring task of manually placing 2500 water tiles at the cost of an unoticably longer start up time. 
	
	Args + Returns: None
	"""
	var yPos = position.y
	var xPos = position.x
	var zPos = position.z
	
	for z in range(-count, count):
		for x in range(-count, count):
			var instance = water_mesh.duplicate()
			instance.position = Vector3(xPos + x * water_size, yPos + water_level, zPos + z * water_size)
			add_child(instance)
	
