extends Control

var pause_menu_active := false
var previous_mouse_mode = Input.MOUSE_MODE_VISIBLE

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
	pause_menu_active = !pause_menu_active
	visible = pause_menu_active
	get_tree().paused = pause_menu_active
	if pause_menu_active:
		previous_mouse_mode = Input.mouse_mode
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = previous_mouse_mode

func _on_continue_pressed() -> void:
	toggle_pause_menu()
	
func _on_restart_pressed() -> void:
	var scene_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(scene_path)

func _on_settings_pressed() -> void:
	print("Settings don't exist.")
	
func _on_exit_to_desktop_pressed() -> void:
	get_tree().quit()

func _on_exit_to_main_menu_pressed() -> void:
	toggle_pause_menu()
	get_tree().change_scene_to_file("res://scenes/menu_scenes/main_menu/main_menu.tscn")
