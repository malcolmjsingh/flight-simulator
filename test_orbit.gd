extends Node3D

@export var camera: Camera3D
@export var follow_position := true
@export var follow_rotation := true
@export var enabled := true   # 👈 toggle this
@export var axis_length := 1.0

func _ready():
	_setup_axis($X_Axis, Vector3.RIGHT, Color.RED)
	_setup_axis($Y_Axis, Vector3.UP, Color.GREEN)
	_setup_axis($Z_Axis, Vector3.FORWARD, Color.BLUE)

func _setup_axis(axis: MeshInstance3D, dir: Vector3, color: Color):
	var mesh := ArrowMesh.new()
	mesh.size = axis_length
	axis.mesh = mesh

	var mat := StandardMaterial3D.new()
	mat.albedo_color = color
	axis.material_override = mat

	axis.look_at(global_position + dir, Vector3.UP)

func _input(event):
	if event.is_action_pressed("toggle_follow"):
		enabled = !enabled
		print("following = ", enabled)


func _process(_delta):
	if not enabled:
		return

	if camera == null:
		return

	var t := global_transform
	var cam_t := camera.global_transform

	if follow_position:
		t.origin = cam_t.origin

	if follow_rotation:
		t.basis = cam_t.basis

	global_transform = t
