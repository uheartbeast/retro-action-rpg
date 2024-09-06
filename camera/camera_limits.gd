class_name CameraLimits
extends Control

func _ready() -> void:
	Events.request_camera_limits.emit.call_deferred(self)
	hide()
