extends RigidBody

export(float) var rotate_force = 10.0

func _integrate_forces(state):
	var input:Vector3 = Vector3()
	if(Input.is_action_pressed("forward")):
		input += Vector3.FORWARD
	if(Input.is_action_pressed("backward")):
		input += Vector3.BACK
	if(Input.is_action_pressed("left")):
		input += Vector3.LEFT
	if(Input.is_action_pressed("right")):
		input += Vector3.RIGHT
	input = input.normalized()
	input = input.rotated(Vector3.UP, $Node/CameraRig.rotation.y+PI/2)
	state.angular_velocity += input

func _process(delta):
	$Node/CameraRig.translation = global_transform.origin
