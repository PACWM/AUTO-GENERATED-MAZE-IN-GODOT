extends Node3D


var SIZE = 25 # Dimezzato, poiché ogni blocco è 2x2x2
@onready var walls_positions: Node3D = $"../walls_positions"
@onready var player: CharacterBody3D = $"../player"
@onready var timer: Timer = $Timer
@onready var EG: Node3D = $"../enemies_generator"

# Direzioni per il movimento nel labirinto: su, giù, sinistra, destra
var directions = [Vector2(0, -1), Vector2(0, 1), Vector2(-1, 0), Vector2(1, 0)]
var maze = []

@export var debug = false

var array_full : Array[Vector3]
var array_empty : Array[Vector3]

var repeats : int = 0

var done : bool = false


func _ready() -> void:
	timer.start(0.05)
	



func generate():
	if SIZE > 50:
		SIZE = 50
	
	
	
	walls_positions.clear()
		
		
	directions = [Vector2(0, -1), Vector2(0, 1), Vector2(-1, 0), Vector2(1, 0)]
	array_full = []
	array_empty = []
	
	
	# Inizializziamo il labirinto con muri (tutti 1)
	maze = []
	for i in range(SIZE):
		var row = []
		for j in range(SIZE):
			row.append(1)  # 1 rappresenta il muro
		maze.append(row)

	# Generiamo il labirinto a partire da una posizione casuale
	var start_pos = Vector2(randi() % SIZE, randi() % SIZE)
	repeats = 0
	
	generate_maze(start_pos)

	# Stampa tutte le posizioni dove il blocco è vuoto (i.e., il percorso)
	for x in range(SIZE):
		for z in range(SIZE):
			if maze[x][z] == 1:  # 0 rappresenta un percorso, 1 rappresenta un muro
				var positions = Vector3(x * 2, 0, z * 2 )  # Espandiamo il blocco in 2x2x2
				array_full.append(positions)
				
			if maze [x][z] == 0:
				var positions = Vector3(x * 2 , 0.5 , z * 2 )
				array_empty.append(positions)
				
				
				
	walls_positions.place_blocks(array_full)
	



	place_player()
	place_end()
	
	await get_tree().process_frame
	
	EG.generate_enemies(array_empty,SIZE)
	

# Funzione per generare il labirinto usando DFS
func generate_maze(pos):
	maze[int(pos.x)][int(pos.y)] = 0  # Impostiamo il punto di partenza come un percorso
	var shuffled_directions = directions.duplicate()
	shuffled_directions.shuffle()  # Mescoliamo le direzioni per rendere il labirinto casuale
	for dir in shuffled_directions:
		var next_pos = pos + dir * 2  # Ci spostiamo di due celle per evitare che i muri si connettano troppo facilmente
			
		if is_valid(next_pos):  # Se la prossima posizione è valida
			var between = pos + dir  # Muri tra la cella corrente e quella successiva
			maze[int(between.x)][int(between.y)] = 0  # Rompiamo il muro tra i due
			generate_maze(next_pos)  # Chiamiamo ricorsivamente per la nuova posizione
			





# Verifica se la prossima posizione è valida (ossia è all'interno della griglia e non è già visitata)
func is_valid(pos):
	if pos.x < 1 or pos.x >= SIZE-1 or pos.y < 1 or pos.y >= SIZE-1:
		return false
	return maze[int(pos.x)][int(pos.y)] == 1




# Funzione per posizionare il player
func place_player():
	var value_found : bool = false
	var pos : Vector2 = Vector2(0,0)
	for x in range(SIZE):
		for z in range(SIZE):
			if maze[x][z] == 0 and not value_found:

				pos = Vector2(x*2,z*2)
				value_found = true
				break
			
	  # Assumi che tu abbia un nodo Player sotto questo nodo
	var player_position = Vector3(pos.x + walls_positions.position.x, 1.5, pos.y + walls_positions.position.z)  # Scala a 2x2x2
	player.position = player_position

func place_end():
	var pos : Vector2 = Vector2(0,0)
	for x in range(SIZE):
		for z in range(SIZE):
			if maze[x][z] == 0:
				pos = Vector2(x*2,z*2)
				
	var end_position = Vector3(pos.x, 1, pos.y )  # Scala a 2x2x2
	walls_positions.place_end(end_position)
				
	
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("reset") and debug == true:
		generate()
		
	if Input.is_action_just_pressed("increase") and debug == true:
		SIZE += 1
		
	if Input.is_action_just_pressed("decrese")  and debug == true:
		SIZE -=1


func _on_timer_timeout() -> void:
	generate()
