extends VehicleWheel3D

@export var is_drive_wheel := false
@export var is_steer_wheel := false

@export var suspension_length := 0.4
@export var suspension_stiffness := 20.0
@export var suspension_damping := 2.5

func _ready():
	add_to_group("car_wheels")

	suspension_rest_length = suspension_length
	suspension_stiffness = suspension_stiffness
	damping_compression = suspension_damping
	damping_relaxation = suspension_damping

	engine = is_drive_wheel
	steering = is_steer_wheel

func apply_drive(throttle, brake, steer):
	if is_drive_wheel:
		engine_force = throttle

	if brake > 0:
		self.brake = brake

	if is_steer_wheel:
		steer_angle = steer
