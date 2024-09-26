extends Level

@onready var camera_target: RemoteTransform2D = $CameraTarget

func _ready() -> void:
	super()
	Events.request_camera_target.emit.call_deferred(camera_target)
