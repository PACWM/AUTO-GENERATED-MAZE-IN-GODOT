extends CSGBox3D
@onready var WGI: Node3D = $"../../walls_generator_index"
@onready var walls_positions: Node3D = $"../../walls_positions"


func _ready() -> void:
	walls_positions.global_position = Vector3(-(size.x/2),1,-(size.z/2))
	print(walls_positions.global_position)

func _process(delta: float) -> void:
	size = Vector3(WGI.SIZE * 2,1,WGI.SIZE * 2)
	walls_positions.global_position = Vector3(-(size.x/2),1,-(size.z/2))
