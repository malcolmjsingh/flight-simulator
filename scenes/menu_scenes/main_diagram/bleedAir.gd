## This piece of code displays next when the user clicks the 'Bleed System' in the cockpit

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE BLEED AIR SYSTEM: 
			\nThe Bleed Air system extracts high-pressure air from the engines to power air 
			conditioning and anti-ice systems.
			\nPilots use these switches to manifold air through the pneumatic system while 
			regulators prevent overpressure. It is the 'lifeblood' for non-electrical systems.
			\nIf a leak occurs, known as a 'wing body overheat,' the affected side must be shut 
			down to prevent airframe heat damage. Total loss results in a loss of cabin 
			pressurization and de-icing, making high-altitude flight impossible."
