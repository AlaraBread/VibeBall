extends RigidBody

export(float) var rotate_force = 0.25
export(float) var jump_force = 4

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
	var normal = Vector3()
	for i in range(state.get_contact_count()):
		normal = state.get_contact_local_normal(i)
		break
	if(Input.is_action_pressed("jump") and normal != Vector3()):
		state.linear_velocity += normal*jump_force

func _process(delta):
	$Node/CameraRig.translation = global_transform.origin

func _ready():
	var color = Color(.5, 0, 0)
	color.h = rand_range(0, 1)
	color.s = 1
	color.v = 0.5
	$MeshInstance.material_override.albedo_color = color
