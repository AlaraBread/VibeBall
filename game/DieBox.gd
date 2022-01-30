extends Area

func _on_DieBox_body_entered(body):
	if(body.is_in_group("player")):
		owner.die()
