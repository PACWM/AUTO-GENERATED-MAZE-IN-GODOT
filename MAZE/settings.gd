extends Control

@onready var data: Node = $data
@onready var text: RichTextLabel = $text
@onready var buttons: BoxContainer = $text/buttons

var pressed : Node = self
var previous_pressed : Node = self


var position_data : int = 0

func _ready() -> void:
	var data = data.read(data.keybinds)
	
	for i in buttons.get_children():
		i.text = data[data.keys()[position_data]]
		position_data +=1
		print(i.name)
		
		
func _process(delta: float) -> void:
	if pressed != self and previous_pressed != pressed:
		print(pressed.name)
		previous_pressed = pressed
		
		
		
func change_key(key):
	pass
