extends Node

const keybinds = "user://data/keybinds.json"
const stats = "user://data/stats.json"
#files


func write(content, file_to_open):
	var file = FileAccess.open(file_to_open, FileAccess.WRITE)
	file.store_string(content)

func read(file_to_open):
	var file = FileAccess.open(file_to_open, FileAccess.READ)
	var content = file.get_as_text()
	return JSON.parse_string(content)
	
