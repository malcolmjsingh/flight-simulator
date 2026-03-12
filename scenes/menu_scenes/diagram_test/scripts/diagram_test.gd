extends Node3D
@onready var camera_3d: Camera3D = $Camera3D
@onready var center_pivot: Node3D = $centerPivot
var is_dragging_right = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("mouse button clicked")
			var mousePosition = event.position
			getObjectUnderMouse(mousePosition)
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.is_pressed():
				is_dragging_right = true
			elif event.is_released():
				is_dragging_right = false
	
	if event is InputEventMouseMotion:
		if is_dragging_right:
			var relativeDrag = event.relative
			var relativeDragX = relativeDrag.x
			center_pivot.rotate_y(relativeDragX/100)

func getObjectUnderMouse(mousePos):
	var worldspace = camera_3d.get_world_3d().direct_space_state
	var start = camera_3d.project_ray_origin(mousePos)
	var end = camera_3d.project_position(mousePos, 1000)
	var result = worldspace.intersect_ray(PhysicsRayQueryParameters3D.create(start,end))
	if (result.has("collider")):
		var collidingObject = result.collider
		if collidingObject.get_node("RichTextLabel"):
			print("has RichTextLabel")
			print(collidingObject.get_node("RichTextLabel"))
			if (collidingObject.get_node("RichTextLabel").visible == true):
				collidingObject.get_node("RichTextLabel").visible = false
			else:
				collidingObject.get_node("RichTextLabel").visible = true
			
	
