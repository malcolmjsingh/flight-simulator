## This piece of code displays next when the user clicks the 'Lighting Switches' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE LIGHTING SWITCHES: 
			\nThe lighting panel controls exterior lights, including Strobe, Beacon, and Landing 
			lights for visibility.
			\nThese allow pilots to see the environment and make the aircraft conspicuous to others. 
			The 'Anti-Collision' beacon warns ground crew that engines are running.
			\nFailure of exterior lighting at night makes the aircraft a hazard to other traffic. 
			Landing lights are also used during the day to prevent bird strikes. Proper use is a key
			part of safety protocols, ensuring visibility to both pilots and controllers."
