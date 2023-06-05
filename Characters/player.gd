extends CharacterBody2D

@export var stopSpeed : float = 20
@export var groundFriction : float = 6

@export var walkSpeed : float = 100.0
@export var fastWalkSpeed : float = 150.0
@export var jogSpeed : float = 200.0
@export var runSpeed : float = 250.0

@export var jump_velocity : float = -150.0
@export var double_jump_velocity : float = -100.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

var deltaFrameTime : float = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false

var direction: Vector2 = Vector2.ZERO
var was_in_air : bool = false

enum states {IDLE, RUNNING, JUMPING, MANTLING}
var state : states = states.IDLE

func _physics_process(delta):
	deltaFrameTime = delta
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else:
		has_double_jumped = false
		
		if was_in_air:
			land()
		
		was_in_air = false

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump()
		elif not has_double_jumped:
			# Then double jump in air
			double_jump()
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down");
	if direction.x != 0 && animated_sprite.animation != "jump_end":
		velocity.x = direction.x * walkSpeed
	else:
		# velocity.x = move_toward(velocity.x, 0, walkSpeed)
		pass
		
	friction()

	move_and_slide()
	update_animation()
	update_facing_direction()
	

func move():
	friction()
			
	
	
	
	
	
func move_accel():
	pass
	
func friction():
	var speed : float = velocity.length()
	
	if (speed < stopSpeed):
		velocity.x = 0
		return
	
	if is_on_floor():
		var drop : float = 0
		var control : float = stopSpeed if speed < stopSpeed else speed
		drop += control * groundFriction * deltaFrameTime
		
		var newSpeed : float = speed - drop
		if (newSpeed < 0):
			newSpeed = 0
	
		newSpeed /= speed 
		velocity *= newSpeed
	print(velocity)

func update_animation():
	if not animation_locked:
		if not is_on_floor():
			animated_sprite.play("jump_loop")
		else:
			# update to idle or run animation
			if direction.x != 0:
				animated_sprite.play("run")
			else:
				animated_sprite.play("idle")
	
func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
		
func jump():
	velocity.y = jump_velocity
	animated_sprite.play("jump_start")
	animation_locked = true
	
func double_jump():
	velocity.y = double_jump_velocity
	animated_sprite.play("jump_double")
	animation_locked = true
	has_double_jumped = true
	
func land():
	animated_sprite.play("jump_end")
	animation_locked = true


func _on_animated_sprite_2d_animation_finished():
	if (["jump_end", "jump_start", "jump_double"].has(animated_sprite.animation)):
		animation_locked = false
