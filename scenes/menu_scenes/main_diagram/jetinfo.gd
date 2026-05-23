## This piece of code displays next when the user clicks the 'Jet Engine' information button

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "The Jet Engine: 
			\nIn a jet engine, the engine accelerates air directly out the back at high speed, creating thrust. 
			Jet airplanes are faster; for example the 737 cruises at around 800-850 km/h, while the De Havilland 
			Dash 8 Q400 cruises at around 650-675 km/h. This matters for longer routes since jet airplanes clearly 
			take less time. To continue the analogy, think of a PC: it requires more energy and takes longer to 
			turn on and turn off, but in return you get really fast performance for long work sessions. Jets are 
			used for medium and long distance travel; for example, the Ottawa to Fort Lauderdale (Florida) is flown 
			on the 737 MAX. In terms of the experience for the passenger, jets are much quieter and smoother to 
			fly in, and they have a faster climb rate and reach cruise faster. They also feel more modern than 
			turboprops, although that is largely due to the fact that turboprop planes have not had redesigns 
			as of yet. Finally, the 737 MAX can hold a much larger capacity of around 160-180 passengers."
