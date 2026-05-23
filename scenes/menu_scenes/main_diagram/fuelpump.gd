## This piece of code displays next when the user clicks the 'Fuel Pump System' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE FUEL PUMP SYSTEM: 
			\nThe fuel pump switches on the overhead panel control the electrical pumps located 
			within the wing and center tanks.
			\nThese pumps ensure a constant, pressurized flow of fuel to the engines and APU. The 
			system includes 'boost pumps' that prevent engine flameouts by maintaining pressure even 
			at high altitudes.
			\nIf a pump fails, the engine can often still run via 'suction feed' at lower altitudes, 
			but high-altitude flight requires active pumping. Failure to monitor pump switches can 
			lead to fuel starvation, even if the tanks are full."
