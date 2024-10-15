extends CharacterBody3D


@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var target: Vector3 = Vector3()
@onready var projectile: Node3D = $"../projectile"
@onready var enemies_generator: Node3D = $"../enemies_generator"
@onready var gui: Control = $"../Camera3D/GUI"
@onready var death: Control = $"../Camera3D/death"

const SPEED = 9

var track : bool = false

var points : int = 0

var damage : int = 10

var _bot_accel = 11

@export var HP : int = 100

var DIR : Vector3

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("complete"):
		track = true
		for i in enemies_generator.get_children():
			i.queue_free()
	
	
	if track == true:
		var direction : Vector3 = Vector3()
	
		
		nav.target_position = target
		
		direction = nav.get_next_path_position() - global_position
		
		direction = direction.normalized()
		
		
		velocity = velocity.lerp(direction * SPEED , _bot_accel * delta)
		
		
		move_and_slide()


	if track == false:

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("sinistra", "destra", "su", "giu")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		
		DIR = Vector3(input_dir.x,0,input_dir.y)
		
		
		
		move_and_slide()
	
	
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack"):
		projectile._attack(self)
	
func _process(delta: float) -> void:
	if HP <= 0:
		death.visible = true
