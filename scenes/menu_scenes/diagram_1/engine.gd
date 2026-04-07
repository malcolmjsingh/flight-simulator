extends Area3D

func _ready():
	# Connect the signal
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "The Jet Engine: 
			\nA jet engine is a propulsion system that generates thrust by accelerating air and 
			exhaust gases. It moves the aircraft forward, providing the speed needed for lift. 
			\nAir is compressed, combusted with fuel, and expelled at high speed. Modern engines 
			use a high bypass ratio for efficiency. Engines are the primary source of motion. 
			\nLoss of thrust reduces speed and lift, potentially leading to a stall. Engines 
			can also provide emergency control through asymmetric thrust and help brake via 
			reversers."
