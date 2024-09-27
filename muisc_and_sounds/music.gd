extends Node

const MUSIC_BUS_STRING: = "Music"

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

signal fade_completed()

func _ready() -> void:
	pass # Replace with function body.

func _get_bus_volume_db() -> float:
	var music_bus_index: = AudioServer.get_bus_index(MUSIC_BUS_STRING)
	return AudioServer.get_bus_volume_db(music_bus_index)

func is_playing_song(song: AudioStream) -> bool:
	return (audio_stream_player.stream == song)

func is_playing_playlist(song_playlist: AudioStreamPlaylist) -> bool:
	return (audio_stream_player.stream == song_playlist)

func play(song: AudioStream) -> void:
	audio_stream_player.volume_db = _get_bus_volume_db()
	audio_stream_player.stream = song
	audio_stream_player.play()

func fade(duration: float = 0.75) -> void:
	if audio_stream_player.playing:
		var bus_volume: = _get_bus_volume_db()
		var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		tween.tween_property(audio_stream_player, "volume_db", -80-bus_volume, duration)
		await tween.finished
	fade_completed.emit()
