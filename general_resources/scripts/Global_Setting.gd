"""
*This file is an "Autoload" file
These are variables that need to be stored globally due to serving as program settings
"""

extends Node

var mouseSensitivity: float = 0.005
var cameraTopClamp: float = PI/4
var cameraBottomClamp: float = -PI/4
var cameraCloseZoomClamp: float = 1.0
var cameraFarZoomClamp: float = 10.0

var cameraFixedPositionOffset: Vector3 = Vector3(0, 1.5, 0)
