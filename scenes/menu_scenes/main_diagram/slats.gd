## This piece of code displays next when the user clicks the 'Slats' on the plane

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE SLATS: 
			\nSlats are extendable surfaces on the leading edge of the wings. They increase lift 
			at low speeds by delaying airflow separation, which is vital for takeoff and landing. 
			\nWhen deployed, slats create a slot for high-energy air to flow over the wing, 
			preventing stalls at high angles of attack. They provide pilot-controlled lift enhancement. 
			\nIf used improperly, the aircraft may stall prematurely during steep climbs. Modern 
			planes often link slat deployment to flap settings to optimize lift and drag automatically."
