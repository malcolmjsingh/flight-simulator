extends Node3D

@onready var dragbox: Panel = $Control/spawnerGUI/dragbox
@onready var dragbox_global_rect: Rect2 = $Control/spawnerGUI/dragbox.get_global_rect()
@onready var spawnerGUI: Control = $Control/spawnerGUI
@onready var vehicle_select_v_box: VBoxContainer = $Control/spawnerGUI/vehicleSelectPanel/ScrollContainer/vehicleSelectVBox
@onready var info_display_panel: RichTextLabel = $Control/spawnerGUI/Control/infoDisplayPanel
@onready var spawn_button: Button = $Control/spawnerGUI/Control/spawnButton
@onready var check_button: CheckButton = $Control/spawnerGUI/dragbox/CheckButton

var mouse_position: Vector2
var currentlyGrabbing = false
var selectedVehicleButton:Button
var canGrab = false

var activeVehicle
var activeCamera

func _ready() -> void:
	process_vehicle_resources_in_folder("res://scenes/utility_scenes/vehicle_spawn_handler/vehicle_resources/")
	setup_vehicle_buttons()

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	mouse_position = get_viewport().get_mouse_position()
	dragbox_global_rect = dragbox.get_global_rect()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			if canGrab == true:
				if event.is_pressed():
					if dragbox_global_rect.has_point(mouse_position):
						currentlyGrabbing = true
				if not event.is_pressed() and currentlyGrabbing == true:
					currentlyGrabbing = false
			elif canGrab == false:
				if event.is_pressed():
					if dragbox_global_rect.has_point(mouse_position):
						canGrab = true
						spawnerGUI.position = Vector2(750, 400)
						check_button.button_pressed = true
	
	if event is InputEventMouseMotion:
		if currentlyGrabbing:
			spawnerGUI.position = spawnerGUI.position + event.relative

func process_vehicle_resources_in_folder(path:String):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if (not dir.current_is_dir()) and ((file_name.ends_with(".tres")) or (file_name.ends_with(".res"))):
				var full_path = path + "/" + file_name
				var resource = ResourceLoader.load(full_path)
				if resource is vehicle:
					print("Processing Vehicle:")
					print("Name: %s" % resource.name)
					var button = Button.new()
					button.text = resource.name
					button.name = resource.name
					button.set_meta("VehicleResource", resource)
					button.add_to_group("vehicleButtons")
					vehicle_select_v_box.add_child(button)
					
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		push_error("Error: Directory not found")

func setup_vehicle_buttons():
	var all_vehicle_buttons = get_tree().get_nodes_in_group("vehicleButtons")
	print(all_vehicle_buttons)
	for button in all_vehicle_buttons:
		button.pressed.connect(_on_vehicle_button_pressed.bind(button))

func _on_vehicle_button_pressed(myButton: Button):
	var buttonVehicleResource = myButton.get_meta("VehicleResource")
	info_display_panel.text = buttonVehicleResource.descriptionString
	selectedVehicleButton = myButton

func _on_spawn_button_pressed() -> void:
	if selectedVehicleButton:
		var buttonVehicleResource = selectedVehicleButton.get_meta("VehicleResource")
		spawnProcedure(buttonVehicleResource.scene)
	else:
		info_display_panel.text = "Please select a Vehicle before attempting to spawn."

func spawnProcedure(scene:PackedScene):
	var sceneInstance = scene.instantiate()
	get_tree().current_scene.add_child(sceneInstance)
	
	for child in sceneInstance.get_children():
		if child.is_in_group("camera"):
			var cameraChild = child
			if cameraChild is Camera3D:
				cameraChild.make_current()
			else:
				var cameraInstance = cameraChild.get_node("OrbitCam/SpringArm3D/Camera3D")
				if cameraInstance is Camera3D:
					cameraInstance.make_current()


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		canGrab = true
		spawnerGUI.position = Vector2(750, 400)
	else:
		currentlyGrabbing = false
		canGrab = false
		spawnerGUI.position = Vector2(750, 645)
