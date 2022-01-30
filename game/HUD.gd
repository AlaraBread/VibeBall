extends Control

func _ready():
	time = Serializer.get("time")
	$CoinLabel.text = str(Serializer.get("coins"))
	Serializer.connect("value_changed", self, "_on_serializer_value_changed")

func _on_serializer_value_changed(key, value):
	if(key == "coins"):
		$CoinLabel.text = str(value)

var time:float = 0
func _process(delta):
	time += delta
	Serializer.set("time", time)
	$Timer.text = format_time(time)

func format_time(t:float):
	return "%02d:%02d:%02d:%02d"%[wrapf(t/(60*60), 0, 60), wrapf(t/60, 0, 60), wrapf(t, 0, 60), wrapf(t*100, 0, 100)]
