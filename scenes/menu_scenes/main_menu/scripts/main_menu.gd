extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/map_scenes/main_map/main_map.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_to_diagram_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu_scenes/diagram_test/diagram_test.tscn")
