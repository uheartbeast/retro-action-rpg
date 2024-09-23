extends Node

signal hero_hurt()
signal request_camera_target(new_target: RemoteTransform2D)
signal request_camera_limits(camera_limits: CameraLimits)
signal request_camera_screenshake(amount: float, duration: float)
signal request_description(title: String, description: String)
signal request_new_action(action_index: int, item_index: int)
signal action_changed(action_index: int, item_index: int)
signal door_entered(door: Door)
