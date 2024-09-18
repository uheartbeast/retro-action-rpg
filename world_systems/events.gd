extends Node

signal hero_hurt()
signal request_camera_target(new_target: RemoteTransform2D)
signal request_camera_limits(camera_limits: CameraLimits)
signal request_camera_screenshake(amount: float, duration: float)
signal request_description(title: String, description: String)
signal request_new_action_one(action_slot_index: int)
signal request_new_action_two(action_slot_index: int)
signal request_new_action_three(action_slot_index: int)
