extends Node

export(String) var next_level:String
export(int) var song_id = 1

func _ready():
	MusicManager.play(song_id)

func die():
	get_tree().change_scene(next_level)
