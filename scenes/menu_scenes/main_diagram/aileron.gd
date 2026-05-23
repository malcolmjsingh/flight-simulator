## This piece of code displays next when the user clicks the 'Ailerons' on the plane

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE AILERONS: 
			\nThe ailerons are primary surfaces on the outer wing trailing edges that control the 
			aircraft's roll.
			\nTurning the control wheel deflects ailerons differentially, creating a lift imbalance 
			that banks the plane. This active process is required for all lateral maneuvers.
			\nWithout them, the aircraft cannot bank effectively, forcing the pilot to use spoilers 
			or asymmetric engine thrust for turns. Incorrect deployment can cause an uncommanded 
			'wing drop' or total loss of roll control."
