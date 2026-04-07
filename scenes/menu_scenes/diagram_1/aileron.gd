extends Area3D

func _ready():
	# Connect the signal
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "The Ailerons: 
			\nAilerons are movable surfaces on the outer edges of the wings. They allow the pilot to 
			control roll, letting the aircraft bank and turn efficiently during flight. 
			\nMoving one aileron up and the opposite down changes the lift on each wing, creating 
			a roll that tilts the aircraft. The pilot commands the roll for precise navigation. 
			\nWithout ailerons, the aircraft cannot roll properly, making turns unsafe. This 
			severely reduces maneuverability, especially in critical emergency situations."
