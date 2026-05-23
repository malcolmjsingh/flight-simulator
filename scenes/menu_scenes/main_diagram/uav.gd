## This piece of code displays next when the user clicks the job titled 'Unmanned Aerial Vehicle Operator'

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "Unmanned Aerial Vehicle Operator: 
			\nDescription: As an unmanned aerial vehicle operator, your job is to control unmanned aircraft 
			for research and development, inspection, or recreational purposes. This provides data and 
			training opportunities without risking a crewed craft, in the case of a severe failure or 
			emergency. You would use remote controls to manuever the vehicle, monitor sensors, and collect 
			images. UAVs usually have automatic stability systems, but the operator can control orientation, 
			altitude, and complete mission objectives. 
			\nRequirements: You should have certification for commercial UAV operation, a technical knowledge 
			of drones, and in certain companies a specific aviation or engineering background. Some future 
			jobs may include mapping, agriculture, inspection, and delivery industries."
