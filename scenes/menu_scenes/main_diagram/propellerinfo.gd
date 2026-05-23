## This piece of code displays next when the user clicks the 'Turboprop Engine information button'

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "The Turboprop Engines: 
			\nIn a turboprop engine, the power is mainly used to spin the propeller, and the propeller 
			pushes the air backward to create thrust. These engines are more efficient for short flights 
			because at lower speeds, the propeller blades actually move large masses of air more 
			efficiently than jet engines. Since shorter flights are mainly composed of take off and landing, 
			without much time to get to higher altitudes, it would be inefficient to use a jet engine. To 
			give a good analogy, think of a laptop: it requires less energy and wakes and sleeps instantly, 
			which is better for quick work, even if you get slower performance. Turboprops are used for shorter 
			regional routes and airports with shorter runways; for example, the Montreal to Ottawa flight is 
			generally on the Dash 8. Turboprops perform better on shorter runways, which makes them better for 
			smaller airports. In terms of the experience for the passenger, turboprops are a bit louder, and 
			there is more noticeable vibration since turboprops are generally smaller, and also because of their 
			propellers. They also have lower cruising altitudes and the Dash 8 can hold around 70-90 passengers."
