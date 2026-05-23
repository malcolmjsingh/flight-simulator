## This piece of code displays next when the user clicks the job titled 'Flight Test Engineer'

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "Flight Test Engineer: 
			\nDescription: You evaluate aircraft performance and systems during the development and 
			modification phase, making sure that the new or modified aircraft can operate safely under 
			all expected conditions. Your job would consist of working with test pilots to collect data 
			on speed, left, controllability, engine performance, and structural behaviour. Using this data, 
			you can analyse and recommend changes or improvements to make the aircraft better. 
			\nRequirements: You should have at least an engineering background in either aeronautics, 
			mechanical, or systems engineering. It’s also beter to be very familiar with testing systems 
			in flight and understanding instrumentation. You should be comfortable with flying on test 
			missions and working in realistic flight simulators."
