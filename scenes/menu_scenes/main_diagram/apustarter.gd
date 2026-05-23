## This piece of code displays next when the user clicks the 'APU Starter' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE APU STARTER: 
			\nThe APU starter switch activates the Auxiliary Power Unit, a small jet engine located 
			in the tail cone.
			\nIt provides independent electrical power and pneumatic air while main engines are 
			shut down. This air is essential to 'crank' and start the main engines at the gate.
			\nIn flight, the APU acts as a critical backup generator if an engine fails. If the 
			APU fails, the aircraft becomes dependent on ground power, and the crew loses a vital 
			secondary power source for emergency restarts."	
