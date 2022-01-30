extends Control

func _ready():
	$CoinLabel.text = str(Serializer.get("coins"))
	Serializer.connect("value_changed", self, "_on_serializer_value_changed")

func _on_serializer_value_changed(key, value):
	if(key == "coins"):
		$CoinLabel.text = str(value)
