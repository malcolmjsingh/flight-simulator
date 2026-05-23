## This piece of code displays next when the user clicks the 'Landing Gear' on the plane

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE LANDING GEAR: 
			\nThe landing gear consists of wheels and structures that support the aircraft on 
			the ground. It absorbs the impact of landings and allows for safe taxiing and takeoff. 
			\nThe gear retracts in flight to reduce drag. While it does not affect airborne 
			stability, it is essential for ground control and stopping via the integrated wheel brakes. 
			\nHard landings can cause severe structural damage. Multi-wheel configurations and 
			nose-wheel steering are used to enhance maneuverability on airport runways."
