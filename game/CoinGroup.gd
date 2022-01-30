extends Spatial

export(int) var coin_id = 0

const OFFSET:Vector3 = Vector3(0, 10000, 0)
func _ready():
	visible = false
	translation += OFFSET
	Serializer.connect("value_changed", self, "_on_serializer_value_changed")
	if(coin_id in Serializer.get("coin_ids")):
		activate()

func _on_serializer_value_changed(key, value):
	if(key == "coin_ids"):
		if(coin_id in value):
			activate()

func activate():
	if(visible):
		return
	visible = true
	translation -= OFFSET
