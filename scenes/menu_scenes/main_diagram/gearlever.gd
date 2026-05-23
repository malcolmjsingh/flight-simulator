## This piece of code displays next when the user clicks the 'Gear Lever' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE LANDING GEAR LEVER: 
			\nThe landing gear lever commands the hydraulic extension and retraction of the nose 
			and main gear.
			\nThe 'OFF' position removes hydraulic pressure from the lines after retraction to 
			prevent wear. A 'lockout' prevents accidental retraction while the aircraft is on the 
			ground.
			\nIf hydraulics fail, pilots use a manual override to let the gear 'free-fall' into 
			place. A gear failure results in a belly landing and massive damage. Green lights are 
			the final confirmation of a safe landing configuration."
