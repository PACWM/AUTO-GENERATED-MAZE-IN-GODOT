extends Node3D

const Projectile_preinstanciated = preload("res://projectile.tscn")

func attack(_rotation : Vector3, damage : int , sender : Node):
	
	var Projectile = Projectile_preinstanciated.instantiate()
	
	Projectile._rotation = _rotation
	Projectile.damage = damage
	Projectile.sender = sender
	add_child(Projectile)
	Projectile.global_position = sender.global_position
