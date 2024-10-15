extends ProgressBar

@onready var entity: CharacterBody3D = $"../../../player"

@onready var health_2: ProgressBar = $"../health_2"

@onready var timer: Timer = $"../Timer"

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	max_value = entity.HP
	health_2.max_value = entity.HP
	value = entity.HP
	health_2.value = entity.HP
	

func _process(delta: float) -> void:
	if entity.HP < value:
		value = entity.HP
		timer.start(0.5)
		
	if entity.HP > value:
		value = entity.HP
		health_2.value = entity.HP



func _on_timer_timeout() -> void:
	health_2.value = entity.HP
