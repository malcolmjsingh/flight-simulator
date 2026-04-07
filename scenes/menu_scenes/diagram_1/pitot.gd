extends Area3D

func _ready():
	# Connect the signal
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "The Pitot Tubes: 
			\nPitot tubes are sensors that measure airspeed by comparing ram and static 
			pressures. This data is critical for pilots and computers to understand the flight state. 
			\nIncorrect readings lead to improper flap settings or stall unawareness. Redundant 
			sensors and heating elements are used to prevent blockages from ice or debris. 
			\nFailures have been linked to serious accidents. In some regions, insects nesting 
			in the tubes can disrupt readings, reducing the pilot's ability to fly safely."
