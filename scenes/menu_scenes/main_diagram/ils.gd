## This piece of code displays next when the user clicks the 'ILS System' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE ILS: 
			\nILS controls tune radio frequencies for precision approaches in low visibility using 
			'Localizer' and 'Glide Slope' signals.
			\nWhen captured, the aircraft follows a precise electronic path to the runway, enabling 
			automated 'Autoland' capabilities.
			\nFailure of the receiver during a foggy approach requires an immediate 'Missed 
			Approach' as the pilots cannot safely see the runway. This system is vital for 
			maintaining schedules, ensuring aircraft can land safely when visual references are 
			almost non-existent for the crew."
