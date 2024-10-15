extends Camera3D

var speed = 2

func _physics_process(delta: float) -> void:
	position += (Vector3(Input.get_axis("ui_left","ui_right"),0,Input.get_axis("ui_up","ui_down")) * speed * delta).normalized() 
	


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("zoom"):
		position.y -= 1
		
	if Input.is_action_just_pressed("dezoom"):
		position.y += 1
