extends CharacterBody2D
class_name Bullet

var lifetime : float = 5

var speed = 100
var direction : Vector2 = Vector2.ZERO

func spawn(direction : Vector2, position : Vector2):
	self.direction = direction
	self.position = position
	pass

func _physics_process(delta):
	var col = move_and_collide(delta * direction * speed)
	lifetime -= delta
	
	if (lifetime < 0):
		print("bullet deleted")
		queue_free()
	
	
	
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta
#
#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#
#	move_and_slide()
	pass
