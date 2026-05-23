## This piece of code displays next when the user clicks the 'Yoke' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE YOKE: 
			\nThe yoke is the primary interface for pitch and roll, connected to the elevators and 
			ailerons via cables.
			\nPulling back raises the nose, while turning the wheel banks the wings. It provides 
			physical 'feel' for the aerodynamic forces hitting the plane.
			\nIf the yoke jams, a 'transfer' system allows the other pilot to take over. It remains 
			the iconic symbol of control, requiring precision and strength to maneuver the aircraft 
			safely in extreme weather or emergency flight conditions. "
