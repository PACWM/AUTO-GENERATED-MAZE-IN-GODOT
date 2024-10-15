extends CharacterBody3D

var speed = 6
var accel = 10
var HP = 10
var damage : int
var done : bool = false
var cooldown : bool = false
var who : Node3D


@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var player: CharacterBody3D = $"../../player"
@onready var nav_zone: NavigationRegion3D = $"../../NAV"
@onready var timer: Timer = $Timer


func _physics_process(delta: float) -> void:
		
	if position.y > 1 :
		queue_free()
	
	
	
	var direction : Vector3 = Vector3()
	
	
	nav.target_position = player.global_position
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed,  accel * delta)
	
	move_and_slide()
	
	
	
func _process(delta: float) -> void:
	if HP <= 0:
		player.points += 1
		queue_free()
		
		
	if who == player and not cooldown:
		player.HP -= damage
		cooldown = true
		timer.start(0.5)



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == player:
		who = player
		
func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == player:
		who = self


func _on_timer_timeout() -> void:
	cooldown = false
