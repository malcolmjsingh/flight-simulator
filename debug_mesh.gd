extends MeshInstance3D

@export var camera: Camera3D
@export var follow_position := true
@export var follow_rotation := true
@export var enabled := true   # 👈 toggle this
@export var axis_length := 1.0

func _ready():
	var st := SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_LINES)

	st.set_color(Color.RED)
	st.add_vertex(Vector3.ZERO)
	st.add_vertex(Vector3.RIGHT * axis_length)

	st.set_color(Color.GREEN)
	st.add_vertex(Vector3.ZERO)
	st.add_vertex(Vector3.UP * axis_length)

	st.set_color(Color.BLUE)
	st.add_vertex(Vector3.ZERO)
	st.add_vertex(Vector3.FORWARD * axis_length)
	mesh = st.commit()

func _input(event):
	if event.is_action_pressed("toggle_follow"):
		enabled = !enabled
		set_as_top_level(not enabled)
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
