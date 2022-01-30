extends Node

"""
This script will save data to a file, and retrieve it from a file.
Intended to be used as a Singleton.
The data must be in key/value pairs.
To set/get data, call get(key) or set(key, value) from somewhere else.
"""

var last_level = -1
# filename in user://
export(String) var save_file:String = "save"
# will save to the file every time you set some data.
# may write a lot depending on application, use with caution.
# to avoid many disk writes,
# prefer manually calling save_to_file() only when needed.
export(bool) var save_on_set:bool = false
# automatically read data from file on startup.
export(bool) var load_on_ready:bool = true

signal value_changed(key, value)
var data = {}
func set(key, value):
	data[key] = value
	if(save_on_set):
		save_to_file()
	emit_signal("value_changed", key, value)

func get(key):
	if(data.has(key)):
		return data[key]
	else:
		return null
# defualt vaules
# in the format [name, value]
var defaults = [["fov", 70], ["sensitivity", 0.1], ["coins", 0], ["coin_ids", []], ["time", 0]]
func _ready():
	randomize()
	if(load_on_ready):
		load_from_file()
	for i in defaults:
		if(get(i[0]) == null):
			set(i[0], i[1])

# this will run when the game exits.
# in html5, it may not run, save_on_write = true may be needed.
func _exit_tree():
	save_to_file()

func save_to_file():
	var dump:String = JSON.print(data) # dump data to a string
	var f:File = File.new()
	var err:int = f.open("user://%s"%save_file, File.WRITE) # open for writing
	if(err == OK):
		f.store_string(dump)
		f.close()
	else:
		print("There was a problem saving data to a file.\nError #%d"%err)

func load_from_file():
	var f:File = File.new()
	var err:int = f.open("user://%s"%save_file, File.READ)
	if(err == OK):
		var text:String = f.get_as_text()
		f.close()
		var new:JSONParseResult = JSON.parse(text)
		if(new.error == OK):
			data = new.result
		else:
			print("Invalid JSON in save file.")
			print(new.error_string)
			save_to_file() # overwrite invalid json data.
	else:
		print("There was a problem loading data from a file\nError #%d"%err)
