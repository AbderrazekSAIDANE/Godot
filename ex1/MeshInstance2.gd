extends MeshInstance

var angle_x

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	angle_x=0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#
func _process(delta):
	angle_x=angle_x+delta
	rotation.x=angle_x
	pass
