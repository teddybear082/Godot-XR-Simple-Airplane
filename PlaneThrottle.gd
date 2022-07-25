extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal plane_throttle_moved(position)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_InteractableSlider_slider_moved(position):
	emit_signal("plane_throttle_moved", position) # Replace with function body.
