extends Node2D

@onready var collider = $Area2D/CollisionShape2D
@export var bullet : PackedScene
@onready var muzzlePosition = $bulletSpawn.position

var aimDirection : Vector2 = Vector2.ZERO

func _process(delta):
	pass

func _physics_process(delta):
	aimDirection = position
	pass

func attack():
	print("Attacked")
	var a = bullet.instantiate()
	get_parent().get_parent().get_parent().add_child(a)
	a.spawn(aimDirection, to_global(muzzlePosition))


