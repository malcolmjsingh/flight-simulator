extends Node3D

@onready var spring_arm_3d: SpringArm3D = $SpringArm3D
@onready var orbit_cam: Node3D = $"."

@export var sensitivity: float = 0.005
@export var topClamp: float = PI/4
@export var bottomClamp: float = -PI/4
@export var closeZoomClamp: float = 1.0
@export var farZoomClamp: float = 10.0

var currentlyClampClicking: bool = false

"""
Hello I am the freaky creature, would you like to go to the theater?
It is featureing me, the freaky creature.
so you COULD call it a creature feature, featuring the freaky creature
Also I am gonng freak you 
"""

func _input(event):
	if event is InputEventMouseMotion and currentlyClampClicking:
		orbit_cam.rotate_y(-event.relative.x * sensitivity)
		# Rotate vertically and clamp
		spring_arm_3d.rotate_x(-event.relative.y * sensitivity)
		spring_arm_3d.rotation.x = clamp(spring_arm_3d.rotation.x, bottomClamp, topClamp)
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			spring_arm_3d.spring_length = spring_arm_3d.spring_length - 0.1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			spring_arm_3d.spring_length = spring_arm_3d.spring_length + 0.1
		spring_arm_3d.spring_length = clamp(spring_arm_3d.spring_length, closeZoomClamp, farZoomClamp)

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("toggle_camera") and not currentlyClampClicking:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		currentlyClampClicking = true
		print("P is pressed")
	elif Input.is_action_just_pressed("toggle_camera"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		currentlyClampClicking = false
		
