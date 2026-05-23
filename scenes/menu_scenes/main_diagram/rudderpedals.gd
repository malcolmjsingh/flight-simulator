## This piece of code displays next when the user clicks the 'Rudder Pedals' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE RUDDER PEDALS: 
			\nRudder pedals control the vertical stabilizer's rudder in flight and nose-wheel steering 
			on the ground.
			\nIn the air, they coordinate turns and counteract 'asymmetric thrust' during an engine 
			failure. On the ground, they also activate the wheel brakes.
			\nFailure of the pedal linkage leaves the pilot unable to steer on the runway or maintain 
			control during crosswind landings. This often results in a 'runway excursion,' where the 
			aircraft slides off the pavement due to a total lack of directional control."
