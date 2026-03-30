extends Node3D
@onready var realrealrealairliner: Node3D = $realrealrealairliner
@onready var ui_animaiton: AnimationPlayer = $"Control/ui animaiton"

enum GUIState {None, ButtonHover, CBoxHover}
var current_gui_state = GUIState.None
var mouse_position: Vector2

@onready var collision_box: BoxContainer = $Control/collisionBox
@onready var to_diagram: Button = $Control/frontBox/toDiagram
@onready var front_box: BoxContainer = $Control/frontBox

var collision_box_rect: Rect2
var to_diagram_rect: Rect2



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_box_rect = collision_box.get_rect()
	to_diagram_rect = to_diagram.get_global_rect()
	print(to_diagram_rect)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	realrealrealairliner.rotate_y(0.1 * delta)
	mouse_position = get_viewport().get_mouse_position()
	
	if collision_box_rect.has_point(mouse_position):
		current_gui_state = GUIState.CBoxHover
	elif to_diagram_rect.has_point(mouse_position):
		current_gui_state = GUIState.ButtonHover
	else:
		current_gui_state = GUIState.None

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/map_scenes/main_map/main_map.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_to_diagram_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_scenes/diagram_test/diagram_test.tscn")
