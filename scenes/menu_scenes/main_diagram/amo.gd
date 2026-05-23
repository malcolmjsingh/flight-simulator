## This piece of code displays next when the user clicks the job titled 'Airline Management Operations'

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "Airline Management Operations: 
			\nDescription: You plan, coordinate, and keep track of airline activities, ensuring that 
			flights operate efficiently, safely, and also profitably. This includes balancing schedules, 
			keeping a track of the staff, and managing logistics. You would handle route planning, crew 
			scheduling, fleet management, and communications with airports and regulators. You need to 
			monitor operational performance and respond quickly to delays and emergencies. You don’t 
			directly contribute to flight operations, but you make sure aircraft operate under safe 
			and regulated conditions. 
			\nRequirements: Luckily, you just need a degree in Aviation Management, business, or logistics 
			(Waterloo has a great Aviation Management program). You should also have experience in 
			airline operations, leadership, and really strong organisational skills. You minaly work 
			behind the scenes but have a huge impact on the door-to-door time for many passengers."
