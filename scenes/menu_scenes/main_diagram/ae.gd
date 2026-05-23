## This piece of code displays next when the user clicks the job titled 'Aeronautical Engineer'

extends Area3D
func _ready():
	input_event.connect(_on_click)
	
func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "Aeronautical Engineer: 
			\nDescription: You design, test, and improve the airframe, engines, and systems to develop safer, more 
			efficient aircraft. You need to have a really strong foundation in physics, aerodynamics, and 
			materials science to model aircraft behaviour, run simulations, and conduct flight tests. If you are 
			taking SPH4U or SCH4U and really and are doing really well, this would be a really good career to go 
			into. You get to improve aircraft stability by experimenting with the wing shape, tail surfaces, and 
			control systems to ensure predictable and safe airplane behaviour. 
			\nRequirements: Requires an engineering degree, preferably in Aerospace/Aerounatical engineering. 
			Having a mechanical engineering degree is just as good. You must have hands-on experience at 
			internships, and licensing and certification for certain types of work. Usually, you start working 
			in maintenance, and then build your way up from them, so if you love being hands on, then this is great. "
