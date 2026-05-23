## This piece of code displays next when the user clicks the 'Engine' on the plane

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE ENGINES
			\nThe aircraft is powered by two high-bypass turbofan engines, providing the thrust 
			required for flight and pneumatic power for cabin systems.
			\nAir is compressed, mixed with fuel, and ignited to produce thrust. On the MAX 
			airframe, these 'LEAP-1B' engines are mounted higher and further forward to maintain 
			ground clearance.
			\nLoss of an engine during takeoff creates a massive 'yaw' toward the failed side. 
			Pilots must use opposite rudder to maintain control. Modern jets are designed to climb 
			and land safely on a single engine in such emergencies."
