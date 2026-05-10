extends Node3D

@onready var spring_arm_3d: SpringArm3D = $SpringArm3D
@onready var orbit_cam: Node3D = $"."
@onready var camera_follow: Node3D = $".."
@onready var camera_3d: Camera3D = $SpringArm3D/Camera3D

@export var sensitivity: float = 0.005
@export var topClamp: float = PI/4
@export var bottomClamp: float = -PI/4
@export var closeZoomClamp: float = 1.0
@export var farZoomClamp: float = 10.0

@export var fixed_cam_position_offset: Vector3 = Vector3(0, 1.5, 0)

@onready var camera_update_label: Label = $"../Control/CameraUpdateControl/CameraUpdateLabel"
@onready var animation_player: AnimationPlayer = $"../Control/AnimationPlayer"
@onready var camera_update_control: Control = $"../Control/CameraUpdateControl"

enum State {ORBIT, FIXED}
var current_state = State.ORBIT
var currentlyCameraToggled: bool = false
var currentlyCameraFocusHeld: bool = false

var mouse_pos: Vector2
var parent_node: Node3D
var orbit_cam_initial_position: Vector3

"""
Hello I am the freaky creature, would you like to go to the theater?
It is featureing me, the freaky creature.
so you COULD call it a creature feature, featuring the freaky creature
Also I am gonng freak you 
"""

func _ready() -> void:
	orbit_cam_initial_position = orbit_cam.position
	camera_update_label.set_modulate(Color(1,1,1,0))
	if camera_follow.get_parent():
		print("found parent")
		parent_node = camera_follow.get_parent()
	else:
		print("failed to find parent")

func _input(event):
	camera_input_handler(event)
	
func _process(_delta: float) -> void:
	camera_control_process_utlity()
	camera_update_handler()
	assignVariablesToGlobalVersionOfVariable()

func assignVariablesToGlobalVersionOfVariable():
	sensitivity = GlobalSetting.mouseSensitivity
	topClamp = GlobalSetting.cameraTopClamp
	bottomClamp = GlobalSetting.cameraBottomClamp
	closeZoomClamp = GlobalSetting.cameraCloseZoomClamp
	farZoomClamp = GlobalSetting. cameraFarZoomClamp
	fixed_cam_position_offset = GlobalSetting.cameraFixedPositionOffset

func camera_control_process_utlity():
	mouse_pos = get_viewport().get_mouse_position()
	if Input.is_action_just_pressed("toggle_camera") and not currentlyCameraToggled:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		currentlyCameraToggled = true
		animation_player.stop()
		animation_player.play("RESET")
		camera_update_label.text = "Camera Clamp Toggled: ON"
		camera_update_control.position = mouse_pos
		animation_player.play("show_and_fade")
	elif Input.is_action_just_pressed("toggle_camera"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		currentlyCameraToggled = false
		animation_player.stop()
		animation_player.play("RESET")
		camera_update_label.text = "Camera Clamp Toggled: OFF"
		camera_update_control.position = mouse_pos
		animation_player.play("show_and_fade")
	
	if not currentlyCameraToggled:
		if Input.is_action_just_pressed("focus_camera") and not currentlyCameraFocusHeld:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			currentlyCameraFocusHeld = true
		elif Input.is_action_just_released("focus_camera") and currentlyCameraFocusHeld:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			currentlyCameraFocusHeld = false
	
	if Input.is_action_just_pressed("cycle_camera"):
		# Cleaned up the state transition logic to properly pass the states
		var next_state = ((current_state + 1) % 2) as State
		on_change_state(current_state, next_state)
		current_state = next_state
		
		#This code just plays a little animation letting you know what camera
		#state you have toggled to.
		camera_update_label.text = "Current State is now: %s" % State.keys()[current_state]
		camera_update_control.position = mouse_pos
		animation_player.play("show_and_fade")
		

func camera_input_handler(event):
	# Handle Zoom for ALL camera states first
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			spring_arm_3d.spring_length = spring_arm_3d.spring_length - 0.1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			spring_arm_3d.spring_length = spring_arm_3d.spring_length + 0.1
		spring_arm_3d.spring_length = clamp(spring_arm_3d.spring_length, closeZoomClamp, farZoomClamp)

	# Handle specific input events based on the camera state
	match current_state:
		State.ORBIT:
			if event is InputEventMouseMotion and (currentlyCameraToggled or currentlyCameraFocusHeld):
				orbit_cam.rotate_y(-event.relative.x * sensitivity)
				# Rotate vertically and clamp
				spring_arm_3d.rotate_x(-event.relative.y * sensitivity)
				spring_arm_3d.rotation.x = clamp(spring_arm_3d.rotation.x, bottomClamp, topClamp)
		State.FIXED:
			# Inputs unique to FIXED mode (if any) would go here
			pass

func camera_update_handler():
	match current_state:
		State.ORBIT:
			pass
		State.FIXED:
			if parent_node:
				# Using global_rotation ensures the camera perfectly aligns with the
				# parent object, regardless of how the Node hierarchy handles transforms.
				orbit_cam.global_rotation = parent_node.global_rotation

func on_change_state(exiting_state, entering_state):
	match entering_state:
		State.ORBIT:
			orbit_cam.position = orbit_cam_initial_position
		State.FIXED:
			orbit_cam.position = fixed_cam_position_offset
			# Snap the SpringArm's X rotation to look slightly down/forward
			# so it doesn't get stuck looking straight down if you transitioned while looking at the floor
			spring_arm_3d.rotation.x = -0.2 
			
	match exiting_state:
		State.ORBIT:
			pass
		State.FIXED:
			pass
