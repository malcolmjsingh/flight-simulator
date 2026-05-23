## This piece of code displays next when the user clicks the 'Mode Control Panel' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE MODE CONTROL PANEL: 
			\nAP/MCP: The autopilot panel lets pilots set heading, altitude, 
			vertical speed, and airspeed. The autothrottle switches let the pilots 
			set specific thrusts to allow for automated control of the engines. 
			\nIt is located on the panel just above the main displays. The autothrottle 
			switches are a part of the MCP. 
			\nFlight Director: This shows guidance on the PFD. It is controlled by the 
			MCP, but displayed on the PFD."
