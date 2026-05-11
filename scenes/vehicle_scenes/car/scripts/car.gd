extends VehicleBody3D

# Constants for wheel values
@export var wheel_friction := 10.5
@export var suspension_restlength := 0.1
@export var suspension_travel := 0.2
@export var suspension_stiffness := 80.0
@export var suspension_force := 150.0
@export var wheel_rollinfluence := 2.0

# Constants for engine values
@export var engine_acceleration := 100.0
@export var engine_power := 200.0
@export var boost_power := 300.0
@export var braking_acceleration := 25.0
@export var braking_force := 100.0
@export var reverse_force := 50.0
@export var steering_sensitivity := 2.0
@export var max_steer := 1.0

# Boolean for if you want to toggle the car off.
@export var driving_car := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	"""
	This function is called when the car is spawned in. It sets all children wheels to have the same values
	Args + Returns: None
	Dependencies: All constants in this file
	"""
	for child in get_children():
		if child is VehicleWheel3D:
			child.wheel_friction_slip = wheel_friction
			child.suspension_stiffness = suspension_stiffness
			child.suspension_travel = suspension_travel
			child.wheel_rest_length = suspension_restlength
			child.suspension_max_force = suspension_force
			child.wheel_roll_influence = wheel_rollinfluence

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	"""
	This function handles user inputs and sets values of the car accordingly.
	
	Args:
	- delta: float
	Returns:
	- None
	"""
	if driving_car:
		if Input.is_action_pressed("pitch_up"):
			# When pitch_up is pressed, the engine force is gradually increased until it reaches max power.
			engine_force += engine_acceleration * delta
			if engine_force > engine_power:
				if Input.is_action_pressed("throttle_up"):
					# If throttle_up is pressed, the engine will exceed maximum power as a "boost mode"
					engine_force = boost_power
				else:
					engine_force = engine_power
			
				
		elif Input.is_action_pressed("pitch_down"):
			# Reverse and brake are both bound to "pitch_down" with the same limits as acceleration
			engine_force -= braking_acceleration * delta
			if engine_force < -braking_force:
				engine_force = -braking_force
		else:
			engine_force = 0
			
		if Input.is_action_just_pressed("pitch_down"):
			# When "pitch_down" is just pressed, it resets the vehicle's angular velocity
			angular_velocity = Vector3.ZERO
		
		if Input.is_action_pressed("roll_left"):
			# "roll_left" allows the vehicle to turn left with steering increasing the longer the key is held.
			if steering < 0:
				steering = 0
			steering += steering_sensitivity * delta * 3
			if steering > max_steer:
				steering = max_steer	
		
		elif Input.is_action_pressed("roll_right"):
			# "roll_right" allows the vehicle to turn right with steering increasing the longer the key is held.
			if steering > 0:
				steering = 0
			steering -= steering_sensitivity * delta * 3
			if steering < -max_steer:
				steering = -max_steer
		
		elif steering != 0.0:
			# If neither key is held and the car is steering, it will gradually decrease the steering until it hits 0.
			if 2 * steering_sensitivity < steering and steering < 2 * steering_sensitivity:
				steering = 0.0
			elif steering > 0:
				steering -= steering_sensitivity * delta
			else:
				steering += steering_sensitivity * delta
		
		if Input.is_action_pressed("throttle_down"):
			# Debug fly is bound to "throttle_down". This may be removed in future releases. 
			rotation = Vector3.ZERO
			position.y += 1.0
		
