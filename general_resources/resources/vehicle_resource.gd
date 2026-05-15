"""
This is a Godot Resource for handling spawning in different types of vehicles. It is to be used by the 
vehicle_spawn_utility system.

The vehicle_spawn_utility scene has a sibling folder called vehicle_resources from which it pulls vehicle resources
to set up the vehicles that are able to be spawned in.

Attributes:
	name (String): name of the vehicle
	descriptionString (String): a description of the vehicle to be displayed
	scene (PackedScene): the scene in which the vehicle is to be stored
"""

class_name vehicle
extends Resource

@export var name: String
@export var scene: PackedScene
@export var descriptionString: String
