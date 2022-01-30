extends Control

func set_paused(p:bool):
	get_tree().paused = p
	visible = get_tree().paused
	if(p):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if(Input.is_action_just_pressed("pause")):
		set_paused(not get_tree().paused)

func _on_Unpause_pressed():
	set_paused(false)
