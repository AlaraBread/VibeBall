extends HSlider
tool

export(String) var save_name:String = ""
export(String) var bus_name:String = ""
export(String) var label_text:String = "" setget set_label_text

func set_label_text(new:String):
	label_text = new
	$Label.text = new

func _ready():
	if(Engine.editor_hint):
		return
	$Label.text = label_text
	if(Serializer.get(save_name) == null):
		Serializer.set(save_name, 0.5)
	value = Serializer.get(save_name)
	_on_AudioSlider_value_changed(value)

func _on_AudioSlider_value_changed(value):
	if(Engine.editor_hint):
		return
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), linear2db(value))
	Serializer.set(save_name, value)
