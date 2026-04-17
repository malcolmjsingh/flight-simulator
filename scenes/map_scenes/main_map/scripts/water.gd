extends Node3D

@export var count := 50
@export var water_mesh : MeshInstance3D
@export var water_size := 20.0
@export var water_level := -100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var yPos = position.y
	var xPos = position.x
	var zPos = position.z
	
	for z in range(-count, count):
		for x in range(-count, count):
			var instance = water_mesh.duplicate()
			instance.position = Vector3(xPos + x * water_size, yPos + water_level, zPos + z * water_size)
			add_child(instance)
		
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	pass
