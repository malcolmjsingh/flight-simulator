extends Control


# I load in a bunch of the ui elements from the options menu so I can either update them and/or
# get their value later.

@onready var mouse_sens_label: Label = $VBoxContainer/Panel/GridContainer/MouseSensLabel
@onready var c_top_clamp_label: Label = $VBoxContainer/Panel/GridContainer/CTopClampLabel
@onready var c_bottom_clamp_label: Label = $VBoxContainer/Panel/GridContainer/CBottomClampLabel
@onready var c_zoom_clamp_close_label: Label = $VBoxContainer/Panel/GridContainer/CZoomClampCloseLabel
@onready var c_zoom_clamp_far_label: Label = $VBoxContainer/Panel/GridContainer/CZoomClampFarLabel
@onready var c_fixed_offset_label: Label = $VBoxContainer/Panel/GridContainer/CFixedOffsetLabel

@onready var mouse_sens_spin_box: SpinBox = $VBoxContainer/Panel/GridContainer/MouseSensSpinBox
@onready var c_top_clamp_spin_box: SpinBox = $VBoxContainer/Panel/GridContainer/CTopClampSpinBox
@onready var c_bottom_clamp_spin_box: SpinBox = $VBoxContainer/Panel/GridContainer/CBottomClampSpinBox
@onready var c_zoom_clamp_close_spin_box: SpinBox = $VBoxContainer/Panel/GridContainer/CZoomClampCloseSpinBox
@onready var c_zoom_clamp_far_spin_box: SpinBox = $VBoxContainer/Panel/GridContainer/CZoomClampFarSpinBox
@onready var c_fixed_offset_x_spin_box: SpinBox = $VBoxContainer/Panel/GridContainer/CFixedOffsetHBoxContainer/CFixedOffsetXSpinBox
@onready var c_fixed_offset_y_spin_box: SpinBox = $VBoxContainer/Panel/GridContainer/CFixedOffsetHBoxContainer/CFixedOffsetYSpinBox
@onready var c_fixed_offset_z_spin_box: SpinBox = $VBoxContainer/Panel/GridContainer/CFixedOffsetHBoxContainer/CFixedOffsetZSpinBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#sets the default value for the number boxes the actual value
	#held by the global
	mouse_sens_spin_box.value = GlobalSetting.mouseSensitivity
	c_top_clamp_spin_box.value = GlobalSetting.cameraTopClamp
	c_bottom_clamp_spin_box.value = GlobalSetting.cameraBottomClamp
	c_zoom_clamp_close_spin_box.value = GlobalSetting.cameraCloseZoomClamp
	c_zoom_clamp_far_spin_box.value = GlobalSetting.cameraFarZoomClamp
	c_fixed_offset_x_spin_box.value = GlobalSetting.cameraFixedPositionOffset[0]
	c_fixed_offset_y_spin_box.value = GlobalSetting.cameraFixedPositionOffset[1]
	c_fixed_offset_z_spin_box.value = GlobalSetting.cameraFixedPositionOffset[2]
	
	#connects the options updated signal to a function called _on_options_updated()
	GlobalSignal.options_updated.connect(_on_options_updated)
	#I call the signal here just to update all of the gui stuff
	_on_options_updated()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_options_updated():
	"""
	Attached to the options_updated signal.
	Updates the options menu display text to display the correct values.
	"""
	mouse_sens_label.text = "Mouse Sensitivity (Current Value: %.3f)" % GlobalSetting.mouseSensitivity
	c_top_clamp_label.text = "Camera Top Clamp (Current Value: %.3f)" % GlobalSetting.cameraTopClamp
	c_bottom_clamp_label.text = "Camera Bottom Clamp (Current Value: %.3f)" % GlobalSetting.cameraBottomClamp
	c_zoom_clamp_close_label.text = "Camera Zoom Clamp Close (Current Value: %.1f)" % GlobalSetting.cameraCloseZoomClamp
	c_zoom_clamp_far_label.text = "Camera Zoom Clamp Far (Current Value: %.1f)" % GlobalSetting.cameraFarZoomClamp
	c_fixed_offset_label.text = "Fixed Cam Offset (Current Value: Vector3(%.1f,%.1f,%.1f))" % [GlobalSetting.cameraFixedPositionOffset[0], GlobalSetting.cameraFixedPositionOffset[1], GlobalSetting.cameraFixedPositionOffset[2]] 

func _on_confirm_changes_button_pressed() -> void:
	"""
	Attached to the "confirm" button "pressed" signal
	Updates the globals holding the settings values and emits the options_changed signal

	"""
	#sets the global settings variables to the 
	#variables held by the number inout boxes
	GlobalSetting.mouseSensitivity = mouse_sens_spin_box.value
	GlobalSetting.cameraTopClamp = c_top_clamp_spin_box.value
	GlobalSetting.cameraBottomClamp = c_bottom_clamp_spin_box.value
	GlobalSetting.cameraCloseZoomClamp = c_zoom_clamp_close_spin_box.value
	GlobalSetting.cameraFarZoomClamp = c_zoom_clamp_far_spin_box.value
	GlobalSetting.cameraFixedPositionOffset = Vector3(c_fixed_offset_x_spin_box.value, c_fixed_offset_y_spin_box.value, c_fixed_offset_z_spin_box.value)
	
	#emits the global options updated signal
	#so that the camera actually updates
	GlobalSignal.options_updated.emit()
	
	"""
	I wrote this code and i think it actually doesn't do anything
	but like im too afraid to delete it
	mouse_sens_spin_box.value = GlobalSetting.mouseSensitivity
	c_top_clamp_spin_box.value = GlobalSetting.cameraTopClamp
	c_bottom_clamp_spin_box.value = GlobalSetting.cameraBottomClamp
	c_zoom_clamp_close_spin_box.value = GlobalSetting.cameraCloseZoomClamp
	c_zoom_clamp_close_spin_box.value = GlobalSetting.cameraFarZoomClamp
	c_fixed_offset_x_spin_box.value = GlobalSetting.cameraFixedPositionOffset[0]
	c_fixed_offset_y_spin_box.value = GlobalSetting.cameraFixedPositionOffset[1]
	c_fixed_offset_z_spin_box.value = GlobalSetting.cameraFixedPositionOffset[2]
	"""

func _on_return_button_pressed() -> void:
	"""
	Attached to the return button "pressed" signal
	Just self destructs the options menu
	"""
	queue_free()
