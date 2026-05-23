## This piece of code displays next when the user clicks the 'Displays' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE DISPLAYS: 
			\nThe display suite includes the PFD and ND, synthesizing flight data into a clear 
			digital format.
			\nThe PFD shows attitude and speed, while the ND provides navigation and weather 
			mapping. These screens replaced dozens of old mechanical gauges.
			\nIf a unit fails, 'display switching' moves data to a functioning screen. Total loss 
			forces the pilot to fly using standby instruments, significantly increasing workload 
			and reducing situational awareness during landings in poor visibility or complex 
			environments."
