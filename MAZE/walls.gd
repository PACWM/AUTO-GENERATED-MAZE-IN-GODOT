extends Node3D

@onready var nav: NavigationRegion3D = $"../NAV"
@onready var _floor: CSGBox3D = $"../NAV/floor"
@onready var NGI: Node3D = $"../walls_generator_index" 
@onready var player: CharacterBody3D = $"../player"




const BLOCK = preload("res://tres.tscn")
const END = preload("res://end.tscn")
var inst_end

var block = false

func place_blocks(blocks_positions : Array[Vector3]):
	#print(len(blocks_positions))
	var repetitions = 0

	for i in blocks_positions:
		var inst_block = BLOCK.instantiate()
		nav.add_child(inst_block)
		inst_block.position  = Vector3(i.x-NGI.SIZE,1.5,i.z-NGI.SIZE)

			
			

func place_end(end_pos : Vector3):
	inst_end = END.instantiate()
	nav.add_child(inst_end)
	inst_end.position = Vector3(end_pos.x-NGI.SIZE,1,end_pos.z-NGI.SIZE)
	player.target = inst_end.position
	
func clear():
	var childs = nav.get_children()
	for i in childs:
		if i != _floor:
			i.queue_free()
	if inst_end:
		inst_end.queue_free()
			
