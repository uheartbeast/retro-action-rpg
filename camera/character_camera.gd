class_name CharacterCamera
extends Camera2D

# We don't want anything directly accessing the camera target
var _target: RemoteTransform2D : set = set_target

func set_target(value: RemoteTransform2D) -> void:
	if _target is RemoteTransform2D:
		_target.remote_path = ""
	_target = value
	_target.remote_path = get_path()
	reset_smoothing()

func _ready() -> void:
	Events.request_camera_target.connect(set_target)
	Events.request_camera_limits.connect(update_limits)

func update_limits(camera_limits: CameraLimits) -> void:
	limit_left = camera_limits.position.x
	limit_right = camera_limits.position.x + camera_limits.size.x
	limit_top = camera_limits.position.y
	limit_bottom = camera_limits.position.y + camera_limits.size.y
