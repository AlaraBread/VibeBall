extends HSlider
tool

export(String) var display_text setget set_display_text
export(String) var save_name

func _ready():
	$Label.text = display_text

func set_display_text(new:String):
	if(is_inside_tree()):
		$Label.text = new
	display_text = new

func _on_OptionSlider_value_changed(value):
	Serializer.set(save_name, value)
