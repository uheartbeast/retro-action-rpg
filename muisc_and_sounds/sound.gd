extends Node

@export_group("Hero Sounds")
@export var swipe: AudioStream
@export var evade: AudioStream
@export var hurt: AudioStream
@export var drop: AudioStream

@export_group("World Sounds")
@export var room_transition: AudioStream
@export var hit: AudioStream
@export var explosion: AudioStream

@export_group("UI Sounds")
@export var menu_move: AudioStream
@export var menu_select: AudioStream
@export var pause: AudioStream
@export var unpause: AudioStream

@onready var audio_stream_players: = get_children()

func play(audio_stream: AudioStream, pitch_scale: = 1.0, volume_db: = 0.0) -> void:
	for audio_stream_player: AudioStreamPlayer in audio_stream_players:
		if not audio_stream_player.playing:
			audio_stream_player.pitch_scale = pitch_scale
			audio_stream_player.volume_db = volume_db
			audio_stream_player.stream = audio_stream
			audio_stream_player.play()
			return
	print("Too many sounds playing at once.")
