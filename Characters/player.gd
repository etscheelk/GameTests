extends CharacterBody2D

@export var stopSpeed : float = 100
@export var groundFriction : float = 6

@export var walkSpeed : float = 100.0
@export var fastWalkSpeed : float = 150.0
@export var jogSpeed : float = 200.0
@export var runSpeed : float = 250.0

@export var groundAcceleration : float = 200
@export var groundDeceleration : float = 600

@export var maxTurnSpeed : float = 80
@export var maxAirTurnSpeed : float = 80

@export var maxAirAcceleration : float = 50
@export var maxAirDeceleration : float = 50

@export var jump_velocity : float = -150.0
@export var double_jump_velocity : float = -100.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var collider : CollisionShape2D = $CollisionShape2D

@onready var tileMap : TileMap = $"../TileMap"

var canClimb : bool = false

var desiredVelocity : Vector2 = Vector2.ZERO
var deltaFrameTime : float = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false

var inputDirection : Vector2 = Vector2.ZERO
var was_in_air : bool = false

enum states {IDLE, RUNNING, JUMPING, MANTLING}
var state : states = states.IDLE

var sprinting : bool = false


func _ready():
	pass


func _process(delta):
	inputDirection = Input.get_vector("left", "right", "up", "down");
	
	desiredVelocity.x = sign(inputDirection.x) * 100
	if sprinting:
		desiredVelocity.x *= 2


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
#			double_jump()
			pass
	
	if Input.is_action_pressed("up"):
		sprinting = true
	if Input.is_action_just_released("up"):
		sprinting = false
	
	# Retrieve the tilemap coordinate at the players center
	var tileMapCoord : Vector2i = tileMap.local_to_map(position)
	
	var tile : TileData = tileMap.get_cell_tile_data(1, tileMapCoord)
	
	canClimb = tile != null
	print(canClimb)
	

	# Get the input inputDirection and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
#	inputDirection = Input.get_vector("left", "right", "up", "down");
	
		
	
#	if (animated_sprite.animation != "jump_end"):
#		# velocity.x = inputDirection.x * walkSpeed
#	friction()
#	accel(Vector2(inputDirection.x, 0), 320, 500)
	
#	velocity.x = move_toward(velocity.x, 0, walkSpeed)

	move()
	move_and_slide()
	update_animation()
	update_facing_inputDirection()
	

func move() -> void:
	var onGround : bool = is_on_floor()
	
	var acceleration = groundAcceleration if onGround else maxAirAcceleration
	var deceleration = groundDeceleration if onGround else maxAirDeceleration
	var turnSpeed    = maxTurnSpeed       if onGround else maxAirTurnSpeed
	
	if inputDirection.y == -1 && canClimb:
		climb()
		return
	
	
	var speedDelta : float = 0
	if (inputDirection.x != 0):
		if (sign(inputDirection.x) != sign(velocity.x)):
			speedDelta = turnSpeed * deltaFrameTime * (2 if sprinting else 1)
		else:
			speedDelta = acceleration * deltaFrameTime * (2 if sprinting else 1)
	else:
		speedDelta = deceleration * deltaFrameTime
		
	velocity.x = move_toward(velocity.x, desiredVelocity.x, speedDelta)
	
#	print(velocity)
	
func climb() -> void:
#	position.y -= 20
	velocity.y = -20
	
	pass


func update_animation() -> void:
	if not animation_locked:
		if not is_on_floor():
			animated_sprite.play("jump_loop")
		else:
			# update to idle or run animation
			if inputDirection.x != 0:
				animated_sprite.play("run")
			else:
				animated_sprite.play("idle")
	
	
func update_facing_inputDirection() -> void:
	if inputDirection.x > 0:
		animated_sprite.flip_h = false
	elif inputDirection.x < 0:
		animated_sprite.flip_h = true
	
		
func jump() -> void:
	velocity.y = jump_velocity
	animated_sprite.play("jump_start")
	animation_locked = true
	
	
func double_jump() -> void:
	velocity.y = double_jump_velocity
	animated_sprite.play("jump_double")
	animation_locked = true
	has_double_jumped = true
	
	
func land() -> void:
	animated_sprite.play("jump_end")
	animation_locked = true


func _on_animated_sprite_2d_animation_finished() -> void:
	if (["jump_end", "jump_start", "jump_double"].has(animated_sprite.animation)):
		animation_locked = false
		

func _on_tile_map_player_touching_background():
	pass # Replace with function body.
