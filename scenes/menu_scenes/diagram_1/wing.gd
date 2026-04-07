extends Area3D

func _ready():
	# Connect the signal
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "The Wing & Spoilers: 
			\nThe wing is the main lifting surface; air flows over its airfoil shape to produce the 
			pressure difference required for flight. Spoilers are panels on the top surface 
			that rise to disrupt this airflow and destroy lift locally. 
			\nThis increases drag to aid in descent and braking. They are intentional, pilot- 
			controlled maneuvers used mainly for reducing airspeed while descending and 
			during the landing phase to ensure the aircraft stays on the runway. 
			\nWhile the wing provides passive lift, the spoilers allow for precise energy 
			management. Incorrect use may limit roll response or cause unsafe speeds."
