extends NavigationRegion3D




func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("complete"):
		bake_navigation_mesh()
