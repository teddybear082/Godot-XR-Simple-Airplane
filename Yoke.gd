extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal yoke_moved(x_angle, y_angle)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_InteractableJoystick_joystick_moved(x_angle, y_angle):
	emit_signal("yoke_moved", x_angle, y_angle) # Replace with function body.
