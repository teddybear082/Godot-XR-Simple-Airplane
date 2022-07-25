extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var plane_already_entered = false
var plane_already_exited = false

# Called when the node enters the scene tree for the first time.
#func _ready():
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func enable_player_controls(boolean_value):
	var functions = get_tree().get_nodes_in_group("movement_providers")
	for each_function in functions:
		each_function.enabled = boolean_value

func _on_Plane_plane_entered(plane_node):
	if plane_already_entered == false:
		plane_already_entered = true
		var arvrorigin = get_parent().get_node("Player")
		var seatcamera = plane_node.get_node("PlayerCameraPosition")
		var playerbodynode = arvrorigin.get_node("PlayerBody")
		playerbodynode.enabled = false
		enable_player_controls(false)
		get_parent().remove_child(arvrorigin)
		plane_node.add_child(arvrorigin)
		arvrorigin.global_transform = seatcamera.global_transform
		ARVRServer.center_on_hmd(ARVRServer.RESET_BUT_KEEP_TILT,false)
		plane_already_exited = false


func _on_Plane_plane_exited(plane_node):
	if plane_already_exited == false:
		plane_already_exited = true
		var arvrorigin = plane_node.get_node("Player")
		var playerbodynode = plane_node.get_node("Player/PlayerBody")
		var exit_plane_camera = plane_node.get_node("ExitPlayerCamera")
		plane_node.remove_child(arvrorigin)
		add_child(arvrorigin)
		arvrorigin.global_transform = exit_plane_camera.global_transform
		playerbodynode.enabled = true
		ARVRServer.center_on_hmd(ARVRServer.RESET_BUT_KEEP_TILT,true)
		enable_player_controls(true)
		plane_already_entered = false
