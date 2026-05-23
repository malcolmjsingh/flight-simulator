## This piece of code displays next when the user clicks the 'Vertical Stabilizer' on the plane

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE VERTICAL STABILIZER: 
			\nThe vertical stabilizer is the fixed surface on the back of the airframe that 
			prevents uncommanded turning caused by turbulence or asymmetric thrust. 
			\nWhen the aircraft sideslips, the wind hits the stabilizer at an angle, 
			creating a lateral force that restores yaw and pulls the nose back into the 
			airflow automatically. 
			\nIt provides passive stability without pilot input. Without it, yaw 
			disturbances compound, making the aircraft uncontrollable due to a loss of 
			directional control."
