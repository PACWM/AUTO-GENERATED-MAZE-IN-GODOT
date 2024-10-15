extends Control
@onready var score: RichTextLabel = $score
@onready var player: CharacterBody3D = $"../../player"


func _process(delta: float) -> void:
	score.text = "punti : " + str(player.points)
