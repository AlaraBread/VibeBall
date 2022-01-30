extends Control

func _process(delta):
	if(not $VideoPlayer.is_playing()):
		$VideoPlayer.play()


func _on_Back_pressed():
	get_tree().change_scene("res://menus/MainMenu.tscn")
