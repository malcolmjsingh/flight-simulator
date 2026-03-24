extends VehicleBody3D

@export var wheel_friction := 10.5
@export var suspension_restlength := 0.15
@export var suspension_travel := 0.2
@export var suspension_stiffness := 5.88
@export var suspension_force := 6000.0

@export var engine_acceleration := 10.0
@export var engine_power := 100.0
@export var braking_acceleration := 25.0
@export var braking_force := 100.0
@export var reverse_force := 50.0
@export var steering_sensitivity := 0.05
@export var max_steer := 1

@export var driving_car := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for child in get_children():
		if child is VehicleWheel3D:
			child.wheel_friction_slip = wheel_friction
			child.suspension_stiffness = suspension_stiffness
			child.suspension_travel = suspension_travel
			child.wheel_rest_length = suspension_restlength
			child.suspension_max_force = suspension_force

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if driving_car:
		if Input.is_action_pressed("pitch_up"):
			engine_force += engine_acceleration * delta
			if engine_force > engine_power:
				engine_force = engine_power
		
		if Input.is_action_pressed("pitch_down"):
			engine_force -= braking_acceleration * delta
			if engine_force < -braking_force:
				engine_force = -braking_force
			
		
		if Input.is_action_pressed("roll_left"):
			steering += steering_sensitivity * delta
			if steering > max_steer:
				steering = max_steer
		
		elif Input.is_action_pressed("roll_right"):
			steering -= steering_sensitivity * delta
			if steering < -max_steer:
				steering = -max_steer
		
		
		
		
