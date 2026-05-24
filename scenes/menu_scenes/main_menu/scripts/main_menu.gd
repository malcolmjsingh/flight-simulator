extends Node3D

# ------------------ Imports --------------------- #
@onready var realrealrealairliner: Node3D = $realrealrealairliner
const OPTIONS_SCENE = preload("uid://32118ukhfbms")

#this loads the behind box elements purely so it can be hidden later
@onready var behind_box: BoxContainer = $Control/behindBox
#var mouse_position: Vector2

# ----------------- Unused ------------------------ #

@onready var ui_animaiton: AnimationPlayer = $"Control/ui animaiton"
enum GUIState {None, ButtonHover, CBoxHover}
var current_gui_state = GUIState.None

@onready var collision_box: BoxContainer = $Control/collisionBox
@onready var to_diagram_collision_box: BoxContainer = $Control/toDiagramCollisionBox
var collision_box_rect: Rect2
var to_diagram_rect: Rect2
var showDiagramButtons: bool = false
var mouse_position = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#gets the collision rectangles for various ui elements to be used with the hover
	#system later on
	collision_box_rect = collision_box.get_rect()
	to_diagram_rect = to_diagram_collision_box.get_global_rect()
	#speed ui the animation because i made it too slow
	ui_animaiton.speed_scale = 3.0
	
	#This hides the unused extra ui elements
	behind_box.modulate = "ffffff00"
	
	#attaches all of the "behind box" buttons to the same signal
	for child in behind_box.get_children():
		if child is Button:
			child.pressed.connect(_on_behind_box_button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#handles the plane spinning animation in the main menu
	realrealrealairliner.rotate_y(0.1 * delta)
	
	#code handiling the ui hover system
	mouse_position = get_viewport().get_mouse_position()
	if collision_box_rect.has_point(mouse_position):
		if current_gui_state == GUIState.ButtonHover:
			current_gui_state = GUIState.CBoxHover
			
	elif to_diagram_rect.has_point(mouse_position):
		if current_gui_state == GUIState.None:
			current_gui_state = GUIState.ButtonHover
			ui_animaiton.play("ui_transition_fwd")
			#print("ui transition fwd passted")
	else:
		if current_gui_state != GUIState.None:
			current_gui_state = GUIState.None
			ui_animaiton.play("ui_transition_bwd")
			#print("ui transition bwd passted")
	
# ---------------------------------------------------------------- #
# ------------------------- SIGNALS ------------------------------ #
# ---------------------------------------------------------------- #

# the following functions are signals attached to button events
# their only purposes are to run a script when a button is clicked
# so I didn't add any docstrings

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/map_scenes/main_map/main_map.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_to_diagram_pressed() -> void:
	"""
	Unused code from the alternate hidden ui elements system
	
	if not showDiagramButtons:
		ui_animaiton.play("ui_transition_fwd")
		showDiagramButtons = true
	else:
		ui_animaiton.play("ui_transition_bwd")
		showDiagramButtons = false
	"""
	get_tree().change_scene_to_file("res://scenes/menu_scenes/main_diagram/hangar.tscn")

func _on_options_pressed() -> void:
	#loads in the options scene
	var options_scene = OPTIONS_SCENE.instantiate()
	add_child(options_scene)

func _on_behind_box_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_scenes/main_diagram/hangar.tscn")
