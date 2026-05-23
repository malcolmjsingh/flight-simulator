## This piece of code displays next when the user clicks the 'Air Conditioning' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE AIR CONDITIONING: 
			\nThe air conditioning system uses Packs and an Isolation Valve to regulate cabin 
			temperature and pressure.
			\nHigh-pressure 'bleed air' is cooled by Air Cycle Machines before entering the cabin. 
			The Isolation Valve ensures pneumatic redundancy between both engines.
			\nWithout this system, the aircraft cannot maintain pressure at altitude, leading to 
			hypoxia. A dual pack failure requires an immediate emergency descent to 10,000 feet. 
			Proper management is vital for passenger safety and structural integrity."
	
