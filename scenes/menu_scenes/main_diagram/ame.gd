## This piece of code displays next when the user clicks the job titled 'Aicraft Maintenance Engineer'

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "Aircraft Maintenance Engineer: 
			\nDescription: You inspect, repair, and maintain aircraft to ensure that they are airworthy 
			(still fit to fly). You must keep aircraft safe and operational by preventing mechanical failures 
			and accidents. This is the most important job when it comes to airline safety as many accidents 
			are caused by poor maintenance after seeminly small incidents. You would perform scheduled 
			inspections, replace faulty or corroded components as per the guidelines, troubleshooting systems, 
			and ensure compliance with aviation regulations. Not following the rules isn’t just a cheap 
			shortcut to save time, but it actually endangers the lives of everyone who flies on the aircraft 
			for months or years to come. 
			\nRequirements: You need to get an aviation maintenance license or diploma, lots of technical 
			and hands-on training, and sometimes specialised certifications for specific aircraft or 
			systems."
