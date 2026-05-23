## This piece of code displays next when the user clicks the job titled 'Aviation Weather Specialist'

extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "Aviation Weather Specialist: 
			\nDescription: You provide information on the weather but only for aviation purposes. 
			You ensure flight safety by predicting the weather for areas where pilots may experience 
			turbulence, nearby storms, wind shear near the runway, and potential icing conditions, 
			which is especially important in Canada. You use satellite data, radar, and atmospheric 
			models to provide pilots and flight planners with accurate information. You advise on 
			which route to take and certain areas that pilots should avoid and altitude adjustments 
			to stay clear of danger. 
			\nRequirements: You should have a degree in meteorology or atmospheric sciences, and 
			specialised aviation weather training, and a useful skills to have is strong analytical 
			skills since not all weather situations are written down in books."
