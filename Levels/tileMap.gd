extends TileMap

signal playerTouchingBackground

@onready var player : CharacterBody2D = $"../../Player"
@export var pos : RemoteTransform2D

# Called when the node enters the scene tree for the first time.
func _ready():
#	clear_layer(1) # Indexed from 0 from layers
#	erase_cell(0, Vector2i(0, 15)) # Based on tilemap origin
#	player.get_collision_layer_value(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get the tile layer the player is touching
#	print(get_cell_atlas_coords(0, Vector2i(0, 15), false)) # I don't know exactly what this does
#	print(local_to_map(pos.to_local(pos.position)))
#	print(player.collision_mask)
	
	pass
	
#func _physics_process(delta):
#	pass
