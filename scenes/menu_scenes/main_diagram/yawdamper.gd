## This piece of code displays next when the user clicks the 'Yaw Damper Switch' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE YAW DAMPER: 
			\nThe yaw damper automatically moves the rudder to counteract 'Dutch Roll,' 
			an unstable rhythmic yawing and rolling motion.
			\nIt works without pilot input to keep the flight smooth and stable, 
			especially at high altitudes. This increases passenger comfort and 
			airframe stability.
			\nIf it fails, the pilot must fly more manually and may face speed 
			or altitude restrictions to stay stable. It is a critical stability 
			aid that assists pilots when aerodynamic damping is naturally weak in 
			the thin upper atmosphere."
