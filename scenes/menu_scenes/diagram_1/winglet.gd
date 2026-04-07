extends Area3D

func _ready():
	# Connect the signal
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "The Winglets: 
			\nWinglets are angled extensions at the wingtips. They reduce wingtip vortices, 
			which decreases induced drag and improves fuel efficiency on long-distance flights. 
			\nBy redirecting airflow, they increase effective lift. Without them, there is 
			higher drag and increased vortex effects, which slightly raises fuel consumption. 
			\nThey are especially beneficial on long-haul aircraft like the A330 or Boeing 757, 
			where small efficiency gains accumulate into significant savings over time."
