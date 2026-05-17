extends Node3D

# --------------------------------------------------------------------------------------------------- #
#                           SPAWNER GUI RELATED IMPORTs / ONREADY                                     #
# ----------------------------------------------------------------------------------------------------#
@onready var dragbox: Panel = $Control/SpawnerGUI/dragbox
@onready var dragbox_global_rect: Rect2 = $Control/SpawnerGUI/dragbox.get_global_rect()
@onready var spawnerGUI: Control = $Control/SpawnerGUI
@onready var vehicle_select_v_box: VBoxContainer = $Control/SpawnerGUI/dragbox/vehicleSelectPanel/ScrollContainer/vehicleSelectVBox
@onready var info_display_panel: RichTextLabel = $Control/SpawnerGUI/dragbox/Control/infoDisplayPanel
@onready var spawn_button: Button = $Control/SpawnerGUI/dragbox/Control/spawnButton
@onready var check_button: CheckButton = $Control/SpawnerGUI/dragbox/CheckButton
@onready var spawn_option_button: OptionButton = $Control/SpawnerGUI/dragbox/SpawnOptionButton
@onready var active_vehicles_box: VBoxContainer = $Control/ActiveVehiclesBox/ScrollContainer/activeVehiclesBox
@onready var active_vehicle_display_label: RichTextLabel = $Control/ActiveVehiclesSelectBox/ActiveVehicleDisplayLabel
@onready var active_vehicles_select_box: Control = $Control/ActiveVehiclesSelectBox
@onready var active_vehicles_box_root: Control = $Control/ActiveVehiclesBox
@onready var active_vehicle_check_toggle: CheckButton = $Control/ActiveVehiclesBox/ActiveVehicleCheckToggle
@onready var delete_vehicle: Button = $Control/ActiveVehiclesSelectBox/DeleteVehicle
@onready var target_camera: Button = $Control/ActiveVehiclesSelectBox/TargetCamera

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
	#The path of the spawn positions is stored in a piece of metadata called "spawn_positions_path" which
	# is attached to the map.
	#Each spawn position is a resource with a name and a vector 3 postition.
	var spawn_positions_path_string = get_tree().current_scene.get_meta("spawn_positions_path")
	collect_spawn_positions_from_directory(spawn_positions_path_string)
	
	#Unselect and spawn options
	spawn_option_button.select(-1)
	
	check_button.button_pressed = true

func _process(_delta: float) -> void:
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
	#This code makes it so you can move the vehicle spawner box around
	#kind of a useless feature
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
						check_button.button_pressed = false 
						
	if event is InputEventMouseMotion:
		if currentlyGrabbing:
			spawnerGUI.position = spawnerGUI.position + event.relative

# --------------------------------------------------------------------------------------------------- #
#                                         SETUP METHODS                                               #
# ----------------------------------------------------------------------------------------------------#

func collect_spawn_positions_from_directory(path:String):
	"""
	This script loads spawn positions resources from a file directory / folder
	and appends the resources it find to the spawn position array
		*this spawn position array is used later alongside the buttons position in the dropdown
		to get the vector 3 position of where the vehicle should be spawned
	
	Args:
		path (String): The path to the spawn positions as a string
	"""
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
	"""
	This script loads vehicle resources from a file directory / folder
	and then creates vehicle spawner select buttons for each of the resources
	it finds in the folder.
	This function also
	- Names the Button and sets the button's text to the button's name
	- Attaches the realted vehicle resource as metadata to the button
	- Connects the button to a signal
	- Adds the button to the scene by making it a child of the vehicle spawner
	v box container
	
	Args:
		path (String): File path to the folder where the vehicle resources
			are stored as a string
	"""
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
	"""
	This is attached to the signal emitted when ever any of the buttons from the active vehicle gui
	(top left) are pressed
	
	It essentially just records which active vehicle is currently selected and updates the gui
	Args:
		myButton (Button): The specific button tha was pressed in order to emit this signal
	"""
	active_vehicles_select_box.visible = true
	currentlySelectedActiveVehicleScene = myButton.get_meta("AssociatedVehicle")
	update_current_active_vehicle_ui()
	currentySelectedActiveVehicleButton = myButton
	#myButton.release_focus()

func _on_vehicle_button_pressed(myButton: Button):
	"""
	This is attached to the signal emitted when ever any of the buttons from the vehicle spawner gui
	(bottom right) are pressed
	
	Records which vehicle was selected and updates the UI
	
	Args:
		myButton (Button): The specific button tha was pressed in order to emit this signal
	"""
	var buttonVehicleResource = myButton.get_meta("VehicleResource")
	info_display_panel.text = buttonVehicleResource.descriptionString
	currentlySelectedVehicleButton = myButton
	#myButton.release_focus()

func _on_spawn_button_pressed() -> void:
	"""
	This is attached to the signal emitted when the "spawn" button is pressed.
	
	It spawns the currently selected vehicle if a vehicle is selected.
	"""
	if currentlySelectedVehicleButton:
		var buttonVehicleResource = currentlySelectedVehicleButton.get_meta("VehicleResource")
		spawnProcedure(buttonVehicleResource.scene)
	else:
		info_display_panel.text = "Please select a Vehicle before attempting to spawn."
	#spawn_button.release_focus()
	
func _on_check_button_toggled(toggled_on: bool) -> void:
	"""
	This function is attached to the signal emitted when the vehicle spawner check button (light switch looking button
	in the bottom right corner) is toggled.
	
	This code was ai generated by Gemini after i realized hardcoding positions for the gui breaks stuff
	when you resize the window.
	
	Args:
		toggled_on (bool): whether the switch was toggled on or not
	"""
	# Get the exact size of the game window and the dragbox
	var screen_size = get_viewport().get_visible_rect().size
	var box_size = dragbox.size
	
	if toggled_on:
		# Toggled ON = Bottom Right (Cannot grab)
		currentlyGrabbing = false
		canGrab = false
		
		# Mathematically place it at the bottom right.
		# (Optional: If you want a small margin so it doesn't touch the screen edge, 
		# change it to: screen_size - box_size - Vector2(10, 10))
		spawnerGUI.position = screen_size - box_size
		
	else:
		# Untoggled OFF = Middle of screen (Can grab)
		canGrab = true
		
		# Mathematically place it in the exact center of the screen
		spawnerGUI.position = (screen_size - box_size) / 2.0

func _on_active_vehicle_check_button_toggled(toggled_on: bool) -> void:
	"""
	This function is attached to the signal emitted when the active vehicle check button (light switch looking button
	in the top left corner) is toggled.
	
	All it really does is just move the active vehicles box out of view or into view.
	*probably shouldn't be hardcoded like this but since its the top left corner it ends up being fine
	Args:
		toggled_on (bool): whether the switch was toggled on or not
	"""
	if toggled_on:
		active_vehicles_box_root.position = Vector2(6, 3)
		active_vehicles_select_box.position = Vector2(0,0)
	else:
		active_vehicles_box_root.position = Vector2(6, -230)
		active_vehicles_select_box.position = Vector2(0,-230)
	#active_vehicle_check_toggle.release_focus()

func _on_new_vehicle_added() -> void:
	"""
	This function is attached to the "newVehicleAdded" signal
	"""
	create_active_vehicle_display_buttons_from_scene()

func _on_delete_vehicle_pressed() -> void:
	"""
	This function is attached to the signal emitted when the "Delete" button is pressed.
	
	This function handles attempting to delete a vehicle from the scene. It also edits a bunch of metadata
	related to the vehicle that was deleted.
	"""
	#hides the gui that shows informaiton about the selected vehicle
	active_vehicles_select_box.visible = false
	#checks if the selected vehicle actually exsists
	if is_instance_valid(currentlySelectedActiveVehicleScene):
		if currentlySelectedActiveVehicleScene == vehicleWithCurrentlyActiveCamera:
			vehicleWithCurrentlyActiveCamera.set_meta("is_camera_active", false)
			vehicleWithCurrentlyActiveCamera = null
		currentlySelectedActiveVehicleScene.queue_free()
		currentySelectedActiveVehicleButton.queue_free()
		currentlySelectedActiveVehicleScene = null
		currentlySelectedVehicleButton = null
	#delete_vehicle.release_focus()
	#target_camera.release_focus()

func _on_target_camera_pressed() -> void:
	"""
	This function is attached to the signal emitted when the "Target Camera" button is pressed.
	
	This function handles attempting to retarget the camera onto a selected vehicle.
		*as a side note, this code is kind of inefficient as i repeat A LOT of the same steps
			but i'm really too lazy to optimise it
	"""
	#checks if you have selected an active vehicle with the active vehicle selection gui (top left)
	if currentlySelectedActiveVehicleScene: 
		#check if there is currently is a vehicle which has the camera focused on it.
		if vehicleWithCurrentlyActiveCamera:
			#checks if the vehicle you have selected already has the camera focusing on it
			if currentlySelectedActiveVehicleScene != vehicleWithCurrentlyActiveCamera:
				#searches for the child node of the vehicle that is a camera and makes that camera active
				#alongside changing a bunch of metadata for the vehicle that previously had the camera
				#and the vehicle that now has the camera
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
			#this code lowkenguinely might just be the same as the above code but it doesn't attempt to
			#set the "is_camera_active" metadata of the previous camera to false
			#regardless, functions pretty much the same as the above code and im too lazy to refractor things
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
	"""
	Takes in the data related to a vehicle and formats the data into a single string
	Args:
		vehicle_name (String)
		is_camera_active (bool)
		vehicle_position (String)
	Returns:
		(String)
	"""
	return "Name: %s \nCamera Target: %s \nPosition: \nX: %d Y: %d Z: %d" % [vehicle_name, str(is_camera_active), vehicle_position.x, vehicle_position.y, vehicle_position.z]

func update_current_active_vehicle_ui():
	"""
	Just updates the ui that displays which of the active/instance vehicles you are currently viewing
	- - - probably didn't need a function for this as its literally just 1 line
	"""
	active_vehicle_display_label.text = create_active_vehicle_ui_string(currentlySelectedActiveVehicleScene.name, currentlySelectedActiveVehicleScene.get_meta("is_camera_active"), currentlySelectedActiveVehicleScene.position)

func create_active_vehicle_display_buttons_from_scene():
	"""
	Creates the buttons for active vehicles display (top left corner ui)
	Does this by deleting all of the current buttons and then creating new buttons based on 
	the children of the vehicle_spawn_handler_storage node 
	(the children of the vehicle spawn handler node are the instanced/active vehicles)
	"""
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
	"""
	This is the code for spawning in a vehicle with the vehicle spawner ui (ui in bottom right corner)
	
	Args:
		scene (PackedScene): This is the scene file of the vehicle that we plan to spawn in
	"""
	
	#This segment handles ensuring that there is a spawn location selected
	if spawn_option_button.get_selected() == -1: #if no spawn location is selected
		info_display_panel.text = "Please select a Location before attempting to spawn. (You can select a location using the dropdown.)"
	elif spawn_option_button.get_selected() >= 0: #if a spawn location is selected
		#this segment handles actually creating the instance of the vehicle and setting up things realted to creating the vehicle
		var sceneInstance = scene.instantiate()
		vehicleThatWasJustAdded = sceneInstance
		sceneInstance.set_meta("is_camera_active", false)
		get_tree().current_scene.get_node("VehicleSpawnHandlerStorage").add_child(sceneInstance)
		#gets the selected spawn position from the spawn position array and moves the vehicle to that position
		var spawnOptionsArray = spawn_option_button.get_meta("spawn_position_resources_array")
		var spawnOptionResource = spawnOptionsArray[spawn_option_button.get_selected()]
		sceneInstance.position = spawnOptionResource.vec3Position
		newVehicleAdded.emit()
		
		#this code tries to find the camera used by the vehicle in order to focus the camera on the vehicle
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
	"""
	This function updates the speedometer in the HUD to match the speed of the vehicle the camera is currently active for.
	
	Args + Returns: None
	"""
	if vehicleWithCurrentlyActiveCamera:
		var velocity = vehicleWithCurrentlyActiveCamera.linear_velocity.length()
		var multiplier = 3
		speedometer_text_box.text = str(int(velocity * multiplier)).pad_zeros(3)
		speedometer_progress_bar.value = int(velocity * multiplier)
		
func update_altimeter():
	"""
	This function updates the altimeter in the HUD to match the altitude of the vehicle the camera is currently active for.
	
	Args + Returns: None
	"""
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
	"""
	This function updates the compass with both the vehicle's horizontal orientation and the camera's horizontal orientation relative to global north.
	
	Args + Returns: None
	"""
	if vehicleWithCurrentlyActiveCamera:
		var vehicle_rotation = vehicleWithCurrentlyActiveCamera.rotation
		var camera_rotation = get_viewport().get_camera_3d().global_rotation
		
		compass_camera.rotation = -camera_rotation.y
		compass_plane.rotation = -vehicle_rotation.y


func _on_spawn_option_dropdown_pressed() -> void:
	pass
	#spawn_option_button.release_focus()
