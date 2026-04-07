extends Area3D

func _ready():
	# Connect the signal
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "The Horizontal Stabilizer and the Elevators: 
			\nThe horizontal stabilizer is the fixed surface providing pitch stability, 
			automatically pushing the plane toward the proper altitude. Attached to its 
			trailing edge, the elevator allows the pilot to actively control pitch. 
			\nDeflecting the elevator changes the tail’s lift to raise or lower the nose, 
			allowing the pilot to change the AOA (angle of attack). This input allows 
			them to override the stabilizer’s passive stability for climbs and descents. 
			\nWithout this system, the aircraft may pitch uncontrollably, making it 
			impossible to maintain level flight and increasing the risk of a stall."
