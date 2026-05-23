## This piece of code displays next when the user clicks the 'Spoilers' in the cockpit


extends Area3D
func _ready():
	input_event.connect(_on_click)

func _on_click(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var label = get_node("/root/Node3D/White_board/Sprite3D/SubViewport/Label")
		label.text = "THE SPEEDBRAKES: 
			\nThe spoiler lever, or speed brake, controls panels on the upper wing to manage lift 
			and drag.
			\nIn flight, extending them allows for rapid descent without gaining speed. On landing, 
			they deploy to 'spoil' lift, forcing the aircraft's weight onto the wheels for better 
			braking.
			\nIf spoilers fail to deploy, the aircraft may 'float' down the runway, significantly 
			increasing landing distance. This creates a high risk of a runway overrun, especially 
			on short or contaminated surfaces."
