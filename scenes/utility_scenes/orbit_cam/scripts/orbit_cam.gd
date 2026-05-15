extends Node3D

# ----------------------- Node Refrences ---------------------------- #

@onready var spring_arm_3d: SpringArm3D = $SpringArm3D
@onready var orbit_cam: Node3D = $"."
@onready var camera_follow: Node3D = $".."
@onready var camera_3d: Camera3D = $SpringArm3D/Camera3D
var parent_node: Node3D

# ------------------------ Orbit Cam Settings ------------------------ #

@export var sensitivity: float = 0.005
@export var topClamp: float = PI/4
@export var bottomClamp: float = -PI/4
@export var closeZoomClamp: float = 1.0
@export var farZoomClamp: float = 10.0
@export var fixed_cam_position_offset: Vector3 = Vector3(0, 1.5, 0)


# ---------------- Update popup stuff --------------------------- #

@onready var camera_update_label: Label = $"../Control/CameraUpdateControl/CameraUpdateLabel"
@onready var animation_player: AnimationPlayer = $"../Control/AnimationPlayer"
@onready var camera_update_control: Control = $"../Control/CameraUpdateControl"
#mouse pos is saved so the animation can be played
#near the mouse each time
var mouse_pos: Vector2
# ----------------------- Camera State Variables ------------------------- #

enum State {ORBIT, FIXED}
var current_state = State.ORBIT
var currentlyCameraToggled: bool = false
var currentlyCameraFocusHeld: bool = false

#orbit cam initial position saved so we can cycle between having the camera
#at the offset position or intial positon
var orbit_cam_initial_position: Vector3

"""
Dinesh wrote this while we were in ontairo chem class so I wont delete it

Hello I am the freaky creature, would you like to go to the theater?
It is featureing me, the freaky creature.
so you COULD call it a creature feature, featuring the freaky creature
Also I am gonng freak you 
"""

func _ready() -> void:
	orbit_cam_initial_position = orbit_cam.position
	#hides the update label by making it transparent
	camera_update_label.set_modulate(Color(1,1,1,0))
	#gets the parent of the orbit cam scene so that its known what object
	#to have the camera follow later on
	if camera_follow.get_parent():
		print("found parent")
		parent_node = camera_follow.get_parent()
	else:
		print("failed to find parent")
	
	GlobalSignal.options_updated.connect(_on_options_updated)

func _input(event):
	camera_input_handler(event)
	
func _process(_delta: float) -> void:
	camera_state_utility()
	camera_update_handler()

func camera_state_utility() -> void:
	"""
	This function handles 
	1. Toggling the camera clamp on and off
	2. The user being able to focus the camera using the right mouse button
	3. Cycling between different camera moves
	"""
	
	#This segment of the code handles toggling the camera clamp on and off
	mouse_pos = get_viewport().get_mouse_position()
	if Input.is_action_just_pressed("toggle_camera") and not currentlyCameraToggled:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		currentlyCameraToggled = true
		currentlyCameraFocusHeld = false
		
		#animaton stuff
		animation_player.stop()
		animation_player.play("RESET")
		camera_update_label.text = "Camera Clamp Toggled: ON"
		camera_update_control.position = mouse_pos
		animation_player.play("show_and_fade")
	elif Input.is_action_just_pressed("toggle_camera"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		currentlyCameraToggled = false
		
		#animaton stuff
		animation_player.stop()
		animation_player.play("RESET")
		camera_update_label.text = "Camera Clamp Toggled: OFF"
		camera_update_control.position = mouse_pos
		animation_player.play("show_and_fade")
	
	#this segment of the code handles focusing the camera on "focus camera" hold
	#it will only run is if the camera is not toggled
	if not currentlyCameraToggled:
		if Input.is_action_just_pressed("focus_camera") and not currentlyCameraFocusHeld:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			currentlyCameraFocusHeld = true
		elif Input.is_action_just_released("focus_camera") and currentlyCameraFocusHeld:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			currentlyCameraFocusHeld = false
	
	#this segment of the code handles cycling the camera between the various camera states
	#originally it was planned to add more states, but two states ended up being a lot cleaner
	if Input.is_action_just_pressed("cycle_camera"):
		var next_state = ((current_state + 1) % 2) as State
		on_change_state(current_state, next_state)
		current_state = next_state
		
		#animaton stuff
		camera_update_label.text = "Current State is now: %s" % State.keys()[current_state]
		camera_update_control.position = mouse_pos
		animation_player.play("show_and_fade")

func camera_input_handler(event):
	"""
	This function handles the input for controlling the camera
	Args:
		event: InputEvent
	"""
	
	#This segment changes the distance of the camera from the object
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			spring_arm_3d.spring_length = spring_arm_3d.spring_length - 0.1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			spring_arm_3d.spring_length = spring_arm_3d.spring_length + 0.1
		spring_arm_3d.spring_length = clamp(spring_arm_3d.spring_length, closeZoomClamp, farZoomClamp)

	# This segment handles specific input events based on the camera state
	match current_state:
		State.ORBIT:
			if event is InputEventMouseMotion and (currentlyCameraToggled or currentlyCameraFocusHeld):
				#Rotates horizontally
				orbit_cam.rotate_y(-event.relative.x * sensitivity)
				#locks the z rotation to prevent weird camera stuff
				orbit_cam.rotation.z = 0
				# Rotate vertically and clamp
				spring_arm_3d.rotate_x(-event.relative.y * sensitivity)
				spring_arm_3d.rotation.x = clamp(spring_arm_3d.rotation.x, bottomClamp, topClamp)
		State.FIXED:
			pass

func camera_update_handler():
	"""
	This function handles updates related to the camera
	"""
	match current_state:
		State.ORBIT:
			pass
		State.FIXED:
			if parent_node:
				#I got gemini to write this part because all the transformation / rotation / global / local
				#stuff was too confusing for me
				
				# Using global_rotation ensures the camera perfectly aligns with the
				# parent object, regardless of how the Node hierarchy handles transforms.
				orbit_cam.global_rotation = parent_node.global_rotation

func on_change_state(exiting_state, entering_state):
	"""
	This function handles changing between states
	"""
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

func _on_options_updated():
	"""
	This function is connected to the "options_updated" signal.
	It essentially just updates all of the camera variables used by this scriptto match the global camera variables.
	"""
	sensitivity = GlobalSetting.mouseSensitivity
	topClamp = GlobalSetting.cameraTopClamp
	bottomClamp	= GlobalSetting.cameraBottomClamp
	closeZoomClamp = GlobalSetting.cameraCloseZoomClamp
	farZoomClamp  = GlobalSetting.cameraFarZoomClamp
	fixed_cam_position_offset = GlobalSetting.cameraFixedPositionOffset
