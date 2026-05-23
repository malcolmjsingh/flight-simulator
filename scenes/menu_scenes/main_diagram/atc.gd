## This piece of code displays next when the user clicks the job titled 'Air Traffic Controller'

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "Air Traffic Controller: 
			\nDescription: You direct aircraft safely in the airspace and on the ground while taxiing, preventing 
			collisions, managing traffic flow in and out of airports, ensuring efficient takeoff, landing, and 
			routing of aircraft. You also manage the airspace and keep track of different aircraft, the most 
			important thing being making sure that airplanes are at different altitudes. You communicate with 
			pilots via radio, provide instructions to climb or descend for altitude and provide headings. You 
			don’t control the aircraft directly, but indirectly influence the pilots in the aircraft, as they rely 
			on you to provide accurate information for take off and landing to ensure safe operation. 
			\nRequirements: Requires special training at an accredited ATC academy and passing licensing exams. 
			You should have excellent situational awareness and communication skills, as well as being able to 
			deal with high pressure work at all times. Lengthy focus, quick decision making, and multitasking to 
			deal with multiple aircraft will make you successful."
