extends VehicleBody3D

@export var camera: Camera3D

@export var Speedometer: Label
@export var Speedbar: TextureProgressBar

@export var MAX_STEER = 0.7
@export var ENGINE_POWER = 100
@export var ENGINE_ACCELERATION = 10
@export var STEER_SENSITIVITY = 0.05

@export var traction = 1
@export var suspension_restlength = 0.5
@export var suspension_force = 20
@export var suspension_travel = 0.2
@export var roll_influence = 0.8

@export var suspension_compression = 4
@export var suspension_relaxation = 4

func _ready() -> void:
	
	$BuggyFL.wheel_friction_slip = traction
	$BuggyFR.wheel_friction_slip = traction
	$BuggyBL.wheel_friction_slip = traction
	$BuggyBR.wheel_friction_slip = traction
	
	$BuggyFL.suspension_stiffness = suspension_force
	$BuggyFR.suspension_stiffness = suspension_force
	$BuggyBL.suspension_stiffness = suspension_force
	$BuggyBR.suspension_stiffness = suspension_force
	
	$BuggyFL.damping_compression = suspension_compression
	$BuggyFR.damping_compression = suspension_compression
	$BuggyBL.damping_compression = suspension_compression
	$BuggyBR.damping_compression = suspension_compression
	
	$BuggyFL.damping_relaxation = suspension_relaxation
	$BuggyFR.damping_relaxation = suspension_relaxation
	$BuggyBL.damping_relaxation = suspension_relaxation
	$BuggyBR.damping_relaxation = suspension_relaxation
	
	$BuggyFL.wheel_roll_influence = roll_influence
	$BuggyFR.wheel_roll_influence = roll_influence
	$BuggyBL.wheel_roll_influence = roll_influence
	$BuggyBR.wheel_roll_influence = roll_influence
	
	

func _process(delta: float) -> void:
	
	
	if camera.camera_state != 0:
		if Input.is_action_pressed("moveForward"):
			engine_force += ENGINE_ACCELERATION
			if engine_force > ENGINE_POWER:
				engine_force = ENGINE_POWER
		else:
			engine_force = 0
		if Input.is_action_pressed("moveBackwards"):
			engine_force = -ENGINE_POWER
			
		if Input.is_action_pressed("moveRight"):
			steering -= STEER_SENSITIVITY
			if steering < -MAX_STEER:
				steering = -MAX_STEER
		elif Input.is_action_pressed("moveLeft"):
			steering += STEER_SENSITIVITY
			if steering > MAX_STEER:
				steering = MAX_STEER
		else:
			steering = 0
			
		if Input.is_action_just_pressed("moveBackwards"):
			angular_velocity = Vector3(0, 0, 0)
		
		if Input.is_action_pressed("moveUp"):
			rotation = Vector3(0, 0, 0)
			position += Vector3(0, 1, 0)
		if Input.is_action_pressed("moveDown"):
			engine_force = ENGINE_POWER * 4
	
	var current_speed = str(int(linear_velocity.length()))
	var speed_text = ""
	for value in range((3 - len(current_speed))):
		speed_text += "0"
	
	Speedometer.text = speed_text + str(current_speed)
	
	var speed_percent = float(current_speed) / 120.0
	Speedbar.value = speed_percent
	
	
