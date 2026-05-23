## This piece of code displays next when the user clicks the 'Navigation Dials' in the cockpit


extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE NAVIGATION DIALS: 
			\nNavigation dials tune VOR and ADF stations, which are ground-based radio beacons for 
			direction finding.
			\nThese provide 'needles' on the cockpit displays to navigate to specific points. While 
			GPS is now primary, these remain the essential backup for navigation.
			\nIf the GPS signal is lost, pilots must revert to these dials to stay on course. 
			Failure to tune them correctly can lead to navigation errors or airspace violations, 
			making them a fundamental part of emergency airmanship training."
