extends Node3D

const PROJECTILE = preload("res://projectile.tscn")

func _attack(sender : Node3D):
	var inst_projectile = PROJECTILE.instantiate()
	
	add_child(inst_projectile)
	
	inst_projectile.position = sender.position
	inst_projectile.dir = sender.DIR
	inst_projectile.sender = sender
	inst_projectile.damage = sender.damage
