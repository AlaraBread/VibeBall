tool
extends HBoxContainer

export(String) var display_action = "" setget set_display
export(String) var action = "" setget set_action

func set_display(new):
	display_action = new
	$Label.text = new

func set_action(new):
	action = new
	$RebindButton.action = new
