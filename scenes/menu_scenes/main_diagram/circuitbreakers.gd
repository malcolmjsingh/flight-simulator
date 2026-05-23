## This piece of code displays next when the user clicks the 'Circuit Breakers' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE CIRCUIT BREAKERS: 
			\nCircuit breakers are the primary electrical safety mechanism for the aircraft's many 
			sub-systems.
			\nEach breaker is designed to 'pop' and disconnect a circuit if it detects an overload, 
			preventing electrical fires. They provide a manual way to de-energize faulty equipment 
			in the cockpit.
			\nA failure of this system could lead to an uncontained electrical fire. These 
			mechanical fuses ensure a single component failure does not cascade into a total loss 
			of the entire electrical grid and flight instrumentation."
		
