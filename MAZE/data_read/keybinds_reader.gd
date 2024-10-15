extends Node

const keybinds = "user://data/keybinds.json"


func save_to_file(content, file_to_open):
	var file = FileAccess.open(file_to_open, FileAccess.WRITE)
	file.store_string(content)

func load_from_file(file_to_open):
	var file = FileAccess.open(file_to_open, FileAccess.READ)
	var content = file.get_as_text()
	return content
	
func read_file():
	return(JSON.parse_string(load_from_file(keybinds)))


func write_file(keybind_to_edit, new_keybind):
	var file = read_file()
	file[keybind_to_edit] = new_keybind
	print(file)
	
