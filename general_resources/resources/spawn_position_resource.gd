"""
This is a Godot Resource for recording the different spawn positions of a map. It is meant to be used in conjunction
with the vehicle spawn handler.

To set up the spawn position resources to be properly used by the vehicle spawn handler, 
spawn position resource files must all be placed in the same folder and the map
must have a piece of metadata called spawn_positions_path that gives the file location of said folder.

Attributes
	name (String): The name of the spawn position to be displayed
	vec3Position (Vector3): The position where the object will be spawned
"""

class_name spawn_position
extends Resource

@export var name: String
@export var vec3Position: Vector3
