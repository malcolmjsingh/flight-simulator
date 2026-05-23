## This piece of code displays next when the user clicks the 'Crossfeed System' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE CROSSFEED SYSTEM: 
			\nThe fuel crossfeed selector is a valve that connects the left and right fuel 
			manifolds.
			\nIt allows fuel from any tank to feed any engine, which is critical for maintaining 
			'lateral imbalance' limits. This ensures the aircraft remains stable and responsive 
			during rolls.
			\nIf the valve fails closed, a weight imbalance can make the plane 'wing-heavy.' If it 
			fails open during a fuel leak, it could lead to a total loss of fuel to both engines, 
			making it a critical item to monitor."
