extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (NodePath) var target_node 
var target = null
# Called when the node enters the scene tree for the first time.
func _ready():
	 target = get_node(target_node)# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(target.global_transform.origin, Vector3.UP)
