extends Control

func _process(delta):
	$Scroll.rect_position.y -= delta*50
