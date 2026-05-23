## This piece of code displays next when the user clicks the 'Thrust Levers' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE THRUST LEVERS: 
			\nThey control the engine power, and are usually split up to allow 
			for situations where differential thrust may be needed. 
			\nIt is located on the center pedestal, between the two seats. "
