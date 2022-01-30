extends Node

func _ready():
	set_process(false)

var volume:float = 0.5
var songs = [
	{
		song=preload("res://assets/music/aethersphere.mp3"),#0
		loop=false
	},
	{
		song=preload("res://assets/music/genesis.mp3"),#1
		loop=false
	}
]
var cur_music = -1

onready var to:AudioStreamPlayer = $MusicPlayer
onready var from:AudioStreamPlayer = $MusicPlayer2
func play(to_song:int):
	if(cur_music == to_song):
		return
	cur_music = to_song
	fade(to_song)

func fade(to_song:int):
	$CrossFadeTimer.stop()
	to = $MusicPlayer
	from = $MusicPlayer2
	if($MusicPlayer.playing):
		to = $MusicPlayer2
		from = $MusicPlayer
	if(to_song >= 0):
		to.stream = songs[to_song]["song"]
		if(songs[to_song]["loop"]):
			$CrossFadeTimer.wait_time = songs[to_song]["loop_point"]
			$CrossFadeTimer.start()
	to.volume_db = linear2db(0)
	to.play()
	$FadeTimer.start()
	set_process(true)

func _on_CrossFadeTimer_timeout():
	fade(cur_music)

var from_volume = 0
func _process(_delta):
	to.volume_db = linear2db(lerp(volume, 0, $FadeTimer.time_left/$FadeTimer.wait_time))
	from.volume_db = linear2db(lerp(0, volume, $FadeTimer.time_left/$FadeTimer.wait_time))
	if($FadeTimer.time_left == 0):
		from.stop()
		set_process(false)
