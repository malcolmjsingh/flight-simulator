extends Area3D

func _ready():
	# Connect the signal
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "The Flaps: 
			\nFlaps are extendable surfaces on the trailing edge of the wings. They increase lift at 
			low speeds, allowing safe takeoff and landing on shorter runways by changing the camber. 
			\nExtending flaps produces more lift but adds drag, letting pilots slow down while remaining 
			airborne. They provide passive lift enhancement rather than direct directional stability. 
			\nWithout flaps, low-speed landings are difficult. Improper use can cause stalls or 
			stress, though planes can land without them if they use significantly more runway."
