class_name LevelMusicPlaylist
extends Node

@export var song_list: AudioStreamPlaylist

func _ready() -> void:
	assert(song_list is AudioStreamPlaylist, "There were no songs in the playlist for this level!")
	if not Music.is_playing_playlist(song_list):
		await Music.fade()
		Music.play(song_list)
