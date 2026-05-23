## This piece of code displays next when the user clicks the job titled 'Avionics Technician'

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "Avionics Technician: 
			\nDescription: You install, maintain, and repair the electronic systems for aircraft. Electrical 
			devices on aircraft relate to navigation, communications, flight control, and making sure they 
			all work as intended. You would troubleshoot failures and perform upgrades/calibrations on the 
			radar, the autopilot, PFDs, GPS, radios, and other electronic equipment. Many airplanes are now 
			fly-by-wire, which means there are many more automated electronic systems. Troubleshooting these, 
			especially on popular aircraft such as the A320 is crucial. 
			\nRequirements: You need hands on training in avionics, electronics, or electrical engineering, 
			as well as maintenance licensing. "
