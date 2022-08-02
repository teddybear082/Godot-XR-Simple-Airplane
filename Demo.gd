extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	#handle haptics  - connect to each controller's pickup function and then connect it to haptic pulse function
	$Player/LeftHandController/Function_Pickup.connect("has_picked_up", self, "haptic_pulse_on_pickup")
	$Player/RightHandController/Function_Pickup.connect("has_picked_up", self, "haptic_pulse_on_pickup")
#	$AirplaneController/Plane/PlaneThrottle.connect("plane_throttle_moved", self, "haptic_pulse_on_throttle")
#	$AirplaneController/Plane/Yoke.connect("yoke_moved", self, "haptic_pulse_on_yoke")

func haptic_pulse_on_pickup(what):
	#What is passed as a parameter by the has_picked_up signal and is the object pickable, in turn that has a _by_controller property that yield the picked up controller
	what.by_controller.set_rumble(0.2)
	yield(get_tree().create_timer(0.2), "timeout")
	what.by_controller.set_rumble(0.0)# Replace with function body.

#	var controller_to_pulse = $AirplaneController/Plane/PlaneThrottle/SliderOrigin/InteractableSlider/HandleOrigin/InteractableHandle.by_controller
#	controller_to_pulse.set_rumble(0.2)
#	yield(get_tree().create_timer(0.2), "timeout")
#	controller_to_pulse.set_rumble(0.0)#
# Called every frame. 'delta' is the elapsed time since the previous frame.

#func haptic_pulse_on_yoke(val1, val2):
#	var controller_to_pulse = $AirplaneController/Plane/Yoke/JoystickOrigin/InteractableJoystick/HandleOrigin/InteractableHandle.by_controller
#	controller_to_pulse.set_rumble(0.2)
#	yield(get_tree().create_timer(0.2), "timeout")
#	controller_to_pulse.set_rumble(0.0)
	
func _process(delta):
	pass
