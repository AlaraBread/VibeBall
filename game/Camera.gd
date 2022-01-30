extends Camera

func _ready():
	Serializer.connect("value_changed", self, "_on_serializer_value_changed")
	fov = Serializer.get("fov")

func _on_serializer_value_changed(key, value):
	if(key == "fov"):
		fov = value
