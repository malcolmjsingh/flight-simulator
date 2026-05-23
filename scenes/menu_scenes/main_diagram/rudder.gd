## This piece of code displays next when the user clicks the 'Rudder' on the plane

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE RUDDER: 
			\nThe rudder is a control surface on the trailing edge of the vertical stabilizer. It allows 
			the pilot to actively control yaw, enabling precise turns and control during engine failures. 
			\nMoving the rudder forces airflow to one side, producing a lateral force at the tail that 
			points the nose. The pilot must provide active input to move it. 
			\nWithout the rudder, the plane remains stable due to the stabilizer, but turns become 
			difficult. Excessive rudder at low speeds can cause dangerous yaw-roll coupling."
