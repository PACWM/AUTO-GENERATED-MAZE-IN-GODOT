extends Node3D

const ENEMY = preload("res://enemy.tscn")
@onready var nav: NavigationRegion3D = $"../NAV"
@onready var NGI: Node3D = $"../walls_generator_index" 

var K : float = 0.3

func generate_enemies(empty: Array[Vector3] , level : int):
	for i in get_children():
		i.free()
	
	
	var len_arr = len(empty)
	var n_enemies = int(K * level)
	
	
	if len_arr == 0:
		return null
	
	for i in n_enemies:
		len_arr = len(empty)
		var picked = randi()%len_arr
		var enemy = ENEMY.instantiate()
		add_child(enemy)
		enemy.position = empty[picked] - Vector3(NGI.SIZE,0,NGI.SIZE)
		enemy.damage = level / 2
		empty.remove_at(picked)
		
	# Vector3(i.x-NGI.SIZE,1.5,i.z-NGI.SIZE)
	
	
	nav.bake_navigation_mesh()
