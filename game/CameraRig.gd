extends Spatial

export(float) var sensitivity = 0.1

func _ready():
	sensitivity = Serializer.get("sensitivity")
	Serializer.connect("value_changed", self, "_on_serializer_value_changed")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_serializer_value_changed(key, value):
	if(key == "sensitivity"):
		sensitivity = value

var mouse:Vector2 = Vector2()
func _input(event):
	if(event is InputEventMouseMotion):
		mouse += event.relative

func _process(delta):
	rotate_y(-mouse.x*sensitivity*delta)
	$SpringArm.rotate_x(-mouse.y*sensitivity*delta)
	$SpringArm.rotation.x = clamp($SpringArm.rotation.x, -PI/2, PI/2)
	mouse = Vector2()
