## This piece of code displays next when the user clicks the job titled 'Commercial Airline Pilot'

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "Commercial Airline Pilot: 
			\nDescription: You fly passenger planes or cargo planes for commercial airlines such as Air 
			Canada, Porter, WestJet, etc. You would be responsible for ensuring that passengers and/or 
			cargo reach their destination safely and on time. You operate the aircraft, monitor instruments, 
			communicate, and follow checklists for taxiing, take-off, departure, cruise, and landing. You 
			plan how much fuel is needed, check weather conditions to ensure the flight is safe, and be 
			able to respond to a variety of emergencies as they come. 
			\nRequirements: You need to have passed flight school, have a CPL (commercial pilot license), 
			and a type rating for a specific aircraft (a special certification that allows you to fly a 
			specific airplane, needed because many airplanes have different rules to follow). If you 
			want to be a captain, you need an ATPL (airline transport pilot license). "
