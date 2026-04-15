extends Node3D

# --------------------------------------------------------------------------------------------------- #
#                           SPAWNER GUI RELATED IMPORTs / ONREADY                                     #
# ----------------------------------------------------------------------------------------------------#
@onready var dragbox: Panel = $Control/SpawnerGUI/dragbox
@onready var dragbox_global_rect: Rect2 = $Control/SpawnerGUI/dragbox.get_global_rect()
@onready var spawnerGUI: Control = $Control/SpawnerGUI
@onready var vehicle_select_v_box: VBoxContainer = $Control/SpawnerGUI/vehicleSelectPanel/ScrollContainer/vehicleSelectVBox
@onready var info_display_panel: RichTextLabel = $Control/SpawnerGUI/Control/infoDisplayPanel
@onready var spawn_button: Button = $Control/SpawnerGUI/Control/spawnButton
@onready var check_button: CheckButton = $Control/SpawnerGUI/dragbox/CheckButton
@onready var spawn_option_button: OptionButton = $Control/SpawnerGUI/SpawnOptionButton
@onready var active_vehicles_box: VBoxContainer = $Control/ActiveVehiclesBox/ScrollContainer/activeVehiclesBox
@onready var active_vehicle_display_label: RichTextLabel = $Control/ActiveVehiclesSelectBox/ActiveVehicleDisplayLabel
@onready var active_vehicles_select_box: Control = $Control/ActiveVehiclesSelectBox
@onready var active_vehicles_box_root: Control = $Control/ActiveVehiclesBox

# --------------------------------------------------------------------------------------------------- #
#                           VEHICLE GUI RELATED IMPORTs / ONREADY                                     #
# ----------------------------------------------------------------------------------------------------#

@onready var speedometer_text_box = $Control/GameplayGUI/MainHUDPiece/Backdrop/SpeedLabel
@onready var speedometer_progress_bar = $Control/GameplayGUI/MainHUDPiece/Backdrop/Speedmeter
@onready var altimeter_label = $Control/GameplayGUI/Altimeter/AltimeterLabel
@onready var altimeter_icon = $Control/GameplayGUI/Altimeter/AltimeterIcon
@onready var compass_camera = $Control/GameplayGUI/Compass/CompassBackground/COControl
@onready var compass_plane = $Control/GameplayGUI/Compass/CompassBackground/POControl

# --------------------------------------------------------------------------------------------------- #
#                                   SPAWNER RELATED VARIABLES                                         #
# ----------------------------------------------------------------------------------------------------#

# ----------------------------------  GUI Input Related stuff ----------------------------------------#

var currentlyGrabbing = false

#This refers to the button of the spawn vehicle UI (bottom right) that is current selected
var currentlySelectedVehicleButton:Button

#This refers to the button of the manage vehicle UI (top left) that is currently selected
var currentySelectedActiveVehicleButton:Button

var mouse_position: Vector2
var canGrab = false

# -------------------------------  Spawn Utility Related stuff ---------------------------------------#

# The vehicles that are spawned are stored as children of a sibling of the vehicle spawn handler called
# vehicle_spawn_handler_storage. These variables are used for setting that up
@onready var vehicle_spawn_handler: Node3D = $"."
var vehicle_spawn_handler_storage = Node3D.new()

# All of these variables are used for the spawning utility.
var vehicleThatWasJustAdded
var vehicleWithCurrentlyActiveCamera
var currentlyActiveCamera
var currentlySelectedActiveVehicleScene = null
signal newVehicleAdded

func _ready() -> void:
	
	#connects the signal newVehicleAdded to the function _on_new_vehicle_added
	self.newVehicleAdded.connect(_on_new_vehicle_added)
	
	#All of the following code is used for setting up the "vehicle_spawn_handler_storage" node as a sibling of
	# the vehicle_spawn_handler node
	# add_sibling doesnt work properly if not call_deferred
	# so need to call_deferred (called at the end of the frame)
	# and then also use await to wait until the end of the frame to have things run properly
	vehicle_spawn_handler_storage.name = "VehicleSpawnHandlerStorage"
	vehicle_spawn_handler.add_sibling.call_deferred(vehicle_spawn_handler_storage)
	await get_tree().process_frame
	
	#This code creates a button for spawning the vehices for each of the vehicle resources in the /vehicle_resources/
	#folder. The data is setup such that the vehicle resource has a name, scene and description
	#and each button has the vehicle resource attached to it in a piece of metadata called "VehicleResource"
	process_vehicle_resources_in_folder("res://scenes/utility_scenes/vehicle_spawn_handler/vehicle_resources/")

	
	#Basically the same thing as the prior code but for spawn postiions.
	#The path of the spawn positions is stored in a piece of metadata called "spawn_positions_path"
	#Each spawn position is a resource with a name and a vector 3 postition.
	var spawn_positions_path_string = get_tree().current_scene.get_meta("spawn_positions_path")
	collect_spawn_positions_from_directory(spawn_positions_path_string)
	
	#Unselect and spawn options
	spawn_option_button.select(-1)

func _process(delta: float) -> void:
	#This is functionality for making the spawner box draggable
	#it gets the camera and the global rect of the dragbox
	mouse_position = get_viewport().get_mouse_position()
	dragbox_global_rect = dragbox.get_global_rect()
	
	#Updates the managing scene UI
	if currentlySelectedActiveVehicleScene:
		update_current_active_vehicle_ui()
	
	""" 
	!!!!!!!!!!!!! I have no Idea what this code does but I don't want to delete it !!!!!!!!!!!!!!!!!!!!!!
	if Input.is_action_just_pressed("ui_accept"):
		print("pressed ui accept")
		create_active_vehicle_display_buttons_from_scene()
	"""
	
	#Updates the Vehicle UI elements
	update_speedometer()
	update_altimeter()
	update_compass()

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

# --------------------------------------------------------------------------------------------------- #
#                                         SETUP METHODS                                               #
# ----------------------------------------------------------------------------------------------------#

func collect_spawn_positions_from_directory(path:String):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if (not dir.current_is_dir()) and ((file_name.ends_with(".tres")) or (file_name.ends_with(".res"))):
				var full_path = path + "/" + file_name
				var resource = ResourceLoader.load(full_path)
				
				if resource is spawn_position:
					var spawn_pos_array = spawn_option_button.get_meta("spawn_position_resources_array")
					spawn_pos_array.append(resource)
					spawn_option_button.add_item(resource.name)
					
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		push_error("Error: Directory not found")

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
					var button = Button.new()
					button.text = resource.name
					button.name = resource.name
					button.set_meta("VehicleResource", resource)
					button.add_to_group("vehicleButtons")
					button.pressed.connect(_on_vehicle_button_pressed.bind(button))
					vehicle_select_v_box.add_child(button)
					
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		push_error("Error: Directory not found")

# --------------------------------------------------------------------------------------------------- #
#                                            SIGNALS                                                  #
# ----------------------------------------------------------------------------------------------------#

func _on_active_vehicle_button_pressed(myButton: Button):
	active_vehicles_select_box.visible = true
	currentlySelectedActiveVehicleScene = myButton.get_meta("AssociatedVehicle")
	update_current_active_vehicle_ui()
	currentySelectedActiveVehicleButton = myButton

func _on_vehicle_button_pressed(myButton: Button):
	var buttonVehicleResource = myButton.get_meta("VehicleResource")
	info_display_panel.text = buttonVehicleResource.descriptionString
	currentlySelectedVehicleButton = myButton

func _on_spawn_button_pressed() -> void:
	if currentlySelectedVehicleButton:
		var buttonVehicleResource = currentlySelectedVehicleButton.get_meta("VehicleResource")
		spawnProcedure(buttonVehicleResource.scene)
	else:
		info_display_panel.text = "Please select a Vehicle before attempting to spawn."
	
	
func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		canGrab = true
		spawnerGUI.position = Vector2(750, 400)
	else:
		currentlyGrabbing = false
		canGrab = false
		spawnerGUI.position = Vector2(750, 645)
	

func _on_active_vehicle_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		active_vehicles_box_root.position = Vector2(6, 3)
		active_vehicles_select_box.position = Vector2(0,0)
	else:
		active_vehicles_box_root.position = Vector2(6, -230)
		active_vehicles_select_box.position = Vector2(0,-230)

func _on_new_vehicle_added() -> void:
	create_active_vehicle_display_buttons_from_scene()

func _on_delete_vehicle_pressed() -> void:
	active_vehicles_select_box.visible = false
	if is_instance_valid(currentlySelectedActiveVehicleScene):
		if currentlySelectedActiveVehicleScene == vehicleWithCurrentlyActiveCamera:
			vehicleWithCurrentlyActiveCamera.set_meta("is_camera_active", false)
			vehicleWithCurrentlyActiveCamera = null
		currentlySelectedActiveVehicleScene.queue_free()
		currentySelectedActiveVehicleButton.queue_free()
		currentlySelectedActiveVehicleScene = null
		currentlySelectedVehicleButton = null

func _on_target_camera_pressed() -> void:
	if currentlySelectedActiveVehicleScene:
		if vehicleWithCurrentlyActiveCamera:
			if currentlySelectedActiveVehicleScene != vehicleWithCurrentlyActiveCamera:
				var foundCam = false
				for child in currentlySelectedActiveVehicleScene.get_children():
					if child.is_in_group("camera"):
						foundCam = true
						vehicleWithCurrentlyActiveCamera.set_meta("is_camera_active", false)
						currentlySelectedActiveVehicleScene.set_meta("is_camera_active", true)
						var cameraChild = child
						if cameraChild is Camera3D:
							cameraChild.make_current()
							currentlyActiveCamera = cameraChild
						else:
							var cameraInstance = cameraChild.get_node("OrbitCam/SpringArm3D/Camera3D")
							if cameraInstance is Camera3D:
								cameraInstance.make_current()
								currentlyActiveCamera = cameraInstance
						vehicleWithCurrentlyActiveCamera = currentlySelectedActiveVehicleScene
						break
				if foundCam == false:
					print("Failed to find camera")
			else:
				print("Note: Selected vehicle already has camera targeted")
		else:
			var foundCam = false
			for child in currentlySelectedActiveVehicleScene.get_children():
				if child.is_in_group("camera"):
					foundCam = true
					currentlySelectedActiveVehicleScene.set_meta("is_camera_active", true)
					var cameraChild = child
					if cameraChild is Camera3D:
						cameraChild.make_current()
						currentlyActiveCamera = cameraChild
					else:
						var cameraInstance = cameraChild.get_node("OrbitCam/SpringArm3D/Camera3D")
						if cameraInstance is Camera3D:
							cameraInstance.make_current()
							currentlyActiveCamera = cameraInstance
					vehicleWithCurrentlyActiveCamera = currentlySelectedActiveVehicleScene
					break
			if foundCam == false:
				print("Failed to find camera")

# --------------------------------------------------------------------------------------------------- #
#                                 VEHICLE SPAWN HANDLER UI METHODS                                    #
# ----------------------------------------------------------------------------------------------------#

func create_active_vehicle_ui_string(vehicle_name: String, is_camera_active: bool, vehicle_position: Vector3) -> String:
	return "Name: %s \nCamera Target: %s \nPosition: \nX: %d Y: %d Z: %d" % [vehicle_name, str(is_camera_active), vehicle_position.x, vehicle_position.y, vehicle_position.z]

func update_current_active_vehicle_ui():
	active_vehicle_display_label.text = create_active_vehicle_ui_string(currentlySelectedActiveVehicleScene.name, currentlySelectedActiveVehicleScene.get_meta("is_camera_active"), currentlySelectedActiveVehicleScene.position)

func create_active_vehicle_display_buttons_from_scene():
	var active_vehicle_box_children = active_vehicles_box.get_children()
	
	#this is like not efficent
	#but also like it works well enough
	#so im probably not going to change it
	for box_child in active_vehicle_box_children:
		box_child.queue_free()
	
	var vehicle_spawn_handler_childern = vehicle_spawn_handler_storage.get_children()
	for child in vehicle_spawn_handler_childern:
		var button = Button.new()
		button.text = child.name
		button.name = child.name
		button.set_meta("AssociatedVehicle", child)
		button.add_to_group("activeVehicleButtons")
		active_vehicles_box.add_child(button)
		button.pressed.connect(_on_active_vehicle_button_pressed.bind(button))
		if child == vehicleThatWasJustAdded:
			_on_active_vehicle_button_pressed(button)

func spawnProcedure(scene:PackedScene):
	if spawn_option_button.get_selected() == -1:
		info_display_panel.text = "Please select a Location before attempting to spawn. (You can select a location using the dropdown.)"
	elif spawn_option_button.get_selected() >= 0:
		var sceneInstance = scene.instantiate()
		vehicleThatWasJustAdded = sceneInstance
		sceneInstance.set_meta("is_camera_active", false)
		get_tree().current_scene.get_node("VehicleSpawnHandlerStorage").add_child(sceneInstance)
		var spawnOptionsArray = spawn_option_button.get_meta("spawn_position_resources_array")
		var spawnOptionResource = spawnOptionsArray[spawn_option_button.get_selected()]
		sceneInstance.position = spawnOptionResource.vec3Position
		newVehicleAdded.emit()
		
		for child in sceneInstance.get_children():
			if child.is_in_group("camera"):
				sceneInstance.set_meta("is_camera_active", true)
				
				if vehicleWithCurrentlyActiveCamera:
					vehicleWithCurrentlyActiveCamera.set_meta("is_camera_active", false)
				vehicleWithCurrentlyActiveCamera = sceneInstance
				
				var cameraChild = child
				if cameraChild is Camera3D:
					cameraChild.make_current()
				else:
					var cameraInstance = cameraChild.get_node("OrbitCam/SpringArm3D/Camera3D")
					if cameraInstance is Camera3D:
						cameraInstance.make_current()
				
				break

# --------------------------------------------------------------------------------------------------- #
#                                        VEHICLE GUI METHODS                                          #
# ----------------------------------------------------------------------------------------------------#

func update_speedometer():
	if vehicleWithCurrentlyActiveCamera:
		var velocity = vehicleWithCurrentlyActiveCamera.linear_velocity.length()
		var multiplier = 3
		speedometer_text_box.text = str(int(velocity * multiplier)).pad_zeros(3)
		speedometer_progress_bar.value = int(velocity * multiplier)
		
func update_altimeter():
	if vehicleWithCurrentlyActiveCamera:
		var height = vehicleWithCurrentlyActiveCamera.position.y
		var sea_level = 220
		var multiplier = 1
		altimeter_label.text = str(int((height + sea_level) * multiplier)) + "m"
		
		var max_icon_pos = -970.0
		var min_icon_pos = -220.0
		var max_altitude = 1000.0
		var min_altitude = 0.0
		
		var percent_offset = (height + sea_level) * multiplier / (max_altitude - min_altitude)
		
		altimeter_icon.position.y = clamp(percent_offset * (max_icon_pos - min_icon_pos) + min_icon_pos, -970.0, -220.0)

func update_compass():
	if vehicleWithCurrentlyActiveCamera:
		var vehicle_rotation = vehicleWithCurrentlyActiveCamera.rotation
		var camera_rotation = get_viewport().get_camera_3d().global_rotation
		
		compass_camera.rotation = -camera_rotation.y
		compass_plane.rotation = -vehicle_rotation.y
