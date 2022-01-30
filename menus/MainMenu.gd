extends Control

func _ready():
	MusicManager.play(0)

func _process(delta):
	if(not $VideoPlayer.is_playing()):
		$VideoPlayer.play()
