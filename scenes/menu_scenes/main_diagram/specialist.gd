## This piece of code displays next when the user clicks the job titled 'Simulator Specialist'

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "Simulator Specialist: 
			\nDescription: You develop and operate flight simulators for pilot training, letting pilots 
			practice common and rare procedures and emergency responses without risking an actual airplane. 
			You would need to simulate cockpit controls, flight dynamics, weather, and emergencies, and guide 
			students through lessons and evaluate their performance much like a teacher.
			\nRequirements: You should have a strong background in aviation, engineering, and software, 
			and a strong experience with real simulators and virtual ones like Microsoft Flight Simulator 
			and X-Plane 12. You should have experience in training programs and good communication and 
			instructional skills. This job is really important because its a major component of pilot 
			certification. It also lets aspiring pilots replicate dangerous scenarios again and again 
			that would be fatal without practise. "
