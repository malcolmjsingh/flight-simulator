## This piece of code displays next when the user clicks the 'Pitot Tubes' on the plane

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE PITOT TUBES: 
			\nPitot tubes measure 'ram air' pressure to calculate airspeed, which is then displayed 
			on the PFD.
			\nThese tubes are electrically heated to prevent ice blockage in flight. The system 
			compares ram air against static air to determine the aircraft's velocity.
			\nIf heaters fail and ice builds up, airspeed readings become 'unreliable,' which can 
			lead to stalls or overspeed. Several major accidents have been linked to pilots reacting 
			incorrectly to blocked pitot tubes, making them high-priority sensors to monitor."
