## This piece of code displays next when the user clicks the job titled 'Aviation Safety Inspector'

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "Aviation Safety Inpsector: 
			\nDescription: You enforce the aviation regulations and safety standards, making sure that the 
			aircraft itself, the pilots, maintenance procedures and the crew, and the airlines comply with 
			the regulations. You examine the plane, review maintenance records, oversee flight operations, 
			and investigate any accidents. You issue ceritfications and make suggestions and create new 
			rules when standards are not met. In a serve case of a crash, you would suggest improves that 
			an airline/aircraft manufacturer should make to their plane and pilots to prevent a similar 
			accident from happening again. 
			\nRequirements: You should have a background in aviation, engineering, or piloting. There is 
			extensive training for this job. if you are good at paying attention to small details and have 
			a strong knowledge of safety standards, this would be a good job for you. Places you would 
			work would include the FAA (USA) and Transport Canada. "
