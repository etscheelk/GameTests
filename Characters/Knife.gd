extends Node2D

@onready var collider = $Area2D/CollisionShape2D
@export var bullet : PackedScene

func attack():
	print("Attacked")
	var a = bullet.instantiate()
	a.spawn(to_global(position), position.angle())


