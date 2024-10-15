extends Button

@onready var settings: Control = $"../../.."

func _on_pressed() -> void:
	settings.pressed = self
