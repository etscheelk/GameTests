extends Camera2D

@export var minZoom : float = 1.0
@export var maxZoom : float = 4.0
@export var zoomDelta : float = 0.25

var currZoom = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _physics_process(delta):
#	if Input.is_action_just_released("zoomin"):
#		currZoom += zoomDelta
#	if Input.is_action_just_released("zoomout"):
#		currZoom -= zoomDelta
#
#	currZoom = clamp(currZoom, minZoom, maxZoom)
#
##	zoom.x = currZoom
##	zoom.y = currZoom
#	ProjectSettings.set_setting("display/window/stretch/scale", currZoom)
#	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("zoomin"):
		currZoom += zoomDelta
	if Input.is_action_just_released("zoomout"):
		currZoom -= zoomDelta

	currZoom = clamp(currZoom, minZoom, maxZoom)

	zoom.x = currZoom
	zoom.y = currZoom
#	ProjectSettings.set_setting("display/window/stretch/scale", currZoom)
#	print(ProjectSettings.get_setting("display/window/stretch/scale"))
	
