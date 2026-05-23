## This piece of code displays next when the user clicks the 'Fuselage' on the plane

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE FUSELAGE: 
			\nThe fuselage is the main body of the aircraft that houses passengers, cargo, and the 
			cockpit. It provides structural support and connects the wings, tail, and gear. 
			\nIts aerodynamic shape reduces drag and distributes structural loads and internal 
			pressurization safely. It contributes to stability but does not directly control flight. 
			\nStructural failure causes catastrophic loss of pressure. Modern designs use lightweight 
			alloys or composites, like the Boeing 787, to maximize durability and fuel efficiency."
