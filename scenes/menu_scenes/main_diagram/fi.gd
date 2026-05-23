## This piece of code displays next when the user clicks the job titled 'Flight Inustructor'

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "Flight Instructor: 
			\nDescription: You teach students how to fly aircraft safely, preparing new pilots to get certified 
			by covering both hands-on flying and theory. You provide demonstrations, supervise student flights, 
			and grade their ability to fly. You guide students through aircraft maneuvers, emergency procedures, 
			and airspace navigation, typically in smaller planes like the Cessna 152 or Piper PA-28. Once ready, 
			students take solo flights performing touch and go procedures and communicating with ATC 
			independently. You also teach managing stability in different wind conditions, handling system failures, 
			and using automated systems like autopilot.
			\nRequirements: You need to have the CPL (commerical pilot license) with instructor certification, 
			and lots of experience in specific aircraft"
