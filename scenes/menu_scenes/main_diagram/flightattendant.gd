## This piece of code displays next when the user clicks the job titled 'Flight Attendant'

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "Flight Attendant: 
			\nDescription: You are responsible for passenger safety and comfort during flights, ensuring that 
			passengers are safely secured in their seats, informed about the status of the plane, and assisted 
			in both routine and emergency situations. You have probably seen this yourself, but you need to know 
			the safety procedures very well, monitor passenger behaviour, provide service, and respond to medical 
			or safety emergencies. You might think it’s as simple as people able to roll a tray from one side to 
			another, but it’s much more than that. You wouldn’t really contribute to the aircraft itself, but you 
			would help maintain flight safety and passenger well-being. 
			\nRequirements: There are airline specific training programs, certification in first aid and safety 
			procedures, and strong communication and interpersonal skills to communicate with passengers 
			effectively. You also need to be prepared for recurrent training for emergency scenarios and 
			security measures. "
