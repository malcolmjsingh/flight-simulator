extends Control

var pause_menu_active := false
var previous_mouse_mode = Input.MOUSE_MODE_VISIBLE
const OPTIONS_SCENE = preload("uid://32118ukhfbms")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = pause_menu_active
	get_tree().paused = pause_menu_active
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		toggle_pause_menu()

func toggle_pause_menu() -> void:
	"""
	Toggles pause menu when called. Handles mouse mode, visibilitiy, and simulation pausing
	
	Args:
	- None
	Returns:
	- None
	"""
	# Toggles the pause state variable
	pause_menu_active = !pause_menu_active
	# Sets visibility accordinly
	visible = pause_menu_active
	# Pauses or unpauses scene accordingly
	get_tree().paused = pause_menu_active
	# Unlocks or locks mouse depending on preivious mouse states and pause_menu_active
	if pause_menu_active:
		previous_mouse_mode = Input.mouse_mode
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = previous_mouse_mode

func _on_continue_pressed() -> void:
	"""
	Calls toggle_paue_menu. This is a wrapper function for a button in the pause menu.
	Args + Returns: None
	"""
	toggle_pause_menu()
	
func _on_restart_pressed() -> void:
	"""
	Restarts the current scene by recalling the scene path, also removes the pause menu.
	Args + Returns: None
	"""
	var scene_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(scene_path)

func _on_settings_pressed() -> void:
	"""
	Opens the options menu while keeping the game paused.
	Args + Returns: None
	"""
	var options_menu = OPTIONS_SCENE.instantiate()
	add_child(options_menu)
	
func _on_exit_to_desktop_pressed() -> void:
	"""
	Closes the software.
	Args + Returns: None
	"""
	get_tree().quit()

func _on_exit_to_main_menu_pressed() -> void:
	"""
	Calls the main_menu scene via hardcoded path, also removes the pause menu. Any tweaks to the path will disrupt this function so please don't do that.
	Args + Returns: None
	"""
	toggle_pause_menu()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().change_scene_to_file("res://scenes/menu_scenes/main_menu/main_menu.tscn")
