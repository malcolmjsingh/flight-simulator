## This piece of code displays next when the user clicks the 'Communication Dials' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE COMMUNICATION DIALS: 
			\nThe communication panel manages radio frequencies for VHF, HF, and interphone voice 
			transmissions.
			\nThese allow the crew to coordinate with Air Traffic Control and dispatch. VHF is used 
			for short-range, while HF handles long-range transoceanic flight.
			\nIf systems fail, the aircraft enters a 'NORDO' (No Radio) state, requiring strict 
			'lost link' procedures to land safely. Clear communication is essential for traffic 
			separation and receiving critical weather updates during all phases of flight."
