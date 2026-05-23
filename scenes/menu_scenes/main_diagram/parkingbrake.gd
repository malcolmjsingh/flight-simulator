## This piece of code displays next when the user clicks the 'Parking Brake' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE PARKING BRAKE: 
			\nThe parking brake is a mechanical latch that maintains hydraulic pressure on the wheel 
			brakes while stationary.
			\nPilots must depress the foot brakes before pulling the lever to 'set' the pressure. It 
			prevents the aircraft from rolling due to wind or jet blast.
			\nIf not set correctly, the aircraft can roll unexpectedly, leading to ground collisions. 
			Conversely, taking off with the brake partially engaged can cause tires to overheat and 
			explode, making it a vital component for ground safety and airframe protection."
