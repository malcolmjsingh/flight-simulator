## This piece of code displays next when the user clicks the 'Flap Levers' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE FLAP LEVERS: 
			\nThe flap lever controls trailing-edge surfaces that increase wing surface area and 
			'camber' for low-speed flight.
			\nExtending flaps increases lift and drag, allowing for safe takeoffs and landings 
			without stalling. Settings range from 0 to 40 based on flight phase.
			\nA jam or 'flap asymmetry' prevents the aircraft from slowing down properly, 
			requiring a dangerous high-speed approach. Flaps are essential for short-field 
			operations, providing the lift necessary to operate out of smaller regional airports 
			safely."
