extends Area3D

func _ready():
	# Connect the signal
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "The Cockpit: 
			\nThe cockpit is the control center at the front of the fuselage. It provides the 
			interfaces for monitoring systems and commanding all primary flight controls. 
			\nPilots use instruments to manage engines, gear, and attitude. Inputs are sent via 
			mechanical links or electronic fly-by-wire technology in modern commercial aircraft. 
			\nModern cockpits integrate automated systems like autopilot and flight computers 
			to assist pilot decisions, ensuring safety even in zero-visibility conditions."
