extends CharacterBody3D

const speed = 30
var dir : Vector3 
var sender : Node3D
var damage : int



func _process(delta: float) -> void:
	velocity = speed * dir
	move_and_slide()
	
	if dir == Vector3.ZERO:
		queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body != sender:
		
		body.HP -= damage
		
		
		
		
		queue_free()
	
		
