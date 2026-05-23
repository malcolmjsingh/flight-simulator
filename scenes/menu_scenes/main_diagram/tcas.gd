## This piece of code displays next when the user clicks the 'TCAS System' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE TCAS: 
			\nThe TCAS dial manages the transponder and the aircraft's automated collision-avoidance 
			logic.
			\nIt interrogates nearby planes to determine their position. If another aircraft is too 
			close, it issues a 'Resolution Advisory,' like 'CLIMB,' to prevent a collision.
			\nIf off, the aircraft is 'invisible' to other safety systems, increasing the risk of a 
			mid-air disaster in crowded airspace. TCAS is a mandatory electronic 'safety net' that 
			prevents accidents when human separation or air traffic control instructions fail."
