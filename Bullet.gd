extends RigidBody2D
class_name Bullet

@export var speed : Vector2 = Vector2(1, 0)
var lifetime : float = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func spawn(pos : Vector2, angle : float):
	print("Bullet Spawned")
	position = pos
	linear_velocity = speed.rotated(angle)
	pass



#func _physics_process(delta):
#	lifetime -= delta
#	if lifetime < 0:
#		print("bullet deleted")
#		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(position)
	lifetime -= delta
	if lifetime < 0:
		print("bullet deleted")
		queue_free()
