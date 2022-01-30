extends StaticBody

export(Vector3) var direction = Vector3.UP
export(float) var distance = 1

var start_pos:Vector3
var end_pos:Vector3

var state = 0
func _ready():
	start_pos = translation
	direction = direction.normalized()
	end_pos = translation+direction*distance

export(float) var speed = 1
func _process(delta):
	match state:
		0:
			direction = (end_pos-translation).normalized()
			translation += direction*(speed*delta)
			if(translation.distance_squared_to(end_pos) < 0.1):
				state = 1
		1:
			direction = (start_pos-translation).normalized()
			translation += direction*(speed*delta)
			if(translation.distance_squared_to(start_pos) < 0.1):
				state = 0
	constant_linear_velocity = direction*speed
