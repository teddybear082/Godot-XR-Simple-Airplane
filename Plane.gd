extends KinematicBody
#tell rest of game when player is in airplane or not
signal plane_entered(plane_node)
signal plane_exited(plane_node)

#Use to prevent glitches where body enters enter or exit areas multiple times
var player_is_seated = false
# Can't fly below this speed
export var min_flight_speed = 10
# Maximum airspeed
export var max_flight_speed = 30
# Turn rate
export var turn_speed = 0.75
# Climb/dive rate
export var pitch_speed = 0.5
# Lerp speed returning wings to level
export var level_speed = 3.0
# Throttle change speed
export var throttle_delta = 30
# Acceleration/deceleration
export var acceleration = 6.0

# Current speed
var forward_speed = 0
# Throttle input speed
var target_speed = 0
# Lets us change behavior when grounded
var grounded = false

var velocity = Vector3.ZERO
var turn_input = 0
var pitch_input = 0


func _ready():
	pass#	DebugOverlay.stats.add_property(self, "grounded", "")
#	DebugOverlay.stats.add_property(self, "forward_speed", "round")
func _process(delta):
	$Info.text = "Speed: " + str(forward_speed) + "Height:" + str(transform.origin.y)	
	
func _physics_process(delta):
	get_input(delta)
	# Rotate the transform based on the input values
	transform.basis = transform.basis.rotated(transform.basis.x, pitch_input * pitch_speed * delta)
	transform.basis = transform.basis.rotated(Vector3.UP, turn_input * turn_speed * delta)
	# If on the ground, don't roll the body
	if grounded:
		$Plane_Mesh.rotation.z = 0
	else:
		# Roll the body based on the turn input
		$Plane_Mesh.rotation.z = lerp($Plane_Mesh.rotation.z, turn_input, level_speed * delta)
	#	$PlaneThrottle.rotation.z = lerp($PlaneThrottle.rotation.z, turn_input, level_speed * delta)
	#	$Yoke.rotation.z = lerp($Yoke.rotation.z, turn_input, level_speed * delta)
#		if player_is_seated:
#			$Player.rotation.z = lerp($Player.rotation.z, turn_input, level_speed * delta)
	# Accelerate/decelerate
	forward_speed = lerp(forward_speed, target_speed, acceleration * delta)
	# Movement is always forward
	velocity = -transform.basis.z * forward_speed
	# Handle landing/taking off
	if is_on_floor():
		if not grounded:
			rotation.x = 0
		velocity.y -= 1
		grounded = true
	else:
		grounded = false
	
	velocity = move_and_slide(velocity, Vector3.UP)

func get_input(delta):
	# Throttle input
	target_speed = max_flight_speed * get_throttle_delta() #* delta
	if not grounded and target_speed < min_flight_speed:
		target_speed = min_flight_speed
		 
	# Turn (roll/yaw) input
	turn_input = 0
	if forward_speed > 0.5:
		turn_input = get_turn_input()
		
	# Pitch (climb/dive) input
	pitch_input = 0
	if not grounded:
		pitch_input = get_pitch_input()
	if forward_speed >= min_flight_speed and get_pitch_input() > 0:
		pitch_input = get_pitch_input()

func get_throttle_delta():
	return $PlaneThrottle/SliderOrigin/InteractableSlider.slider_position / .4
#	return $Plane_Mesh/PlaneThrottle/SliderOrigin/InteractableSlider.slider_position
	
func get_turn_input():
	return -$Yoke/JoystickOrigin/InteractableJoystick.joystick_x_position / 45
#	return -$Plane_Mesh/Yoke/JoystickOrigin/InteractableJoystick.joystick_x_position / 45
		
func get_pitch_input():
	return $Yoke/JoystickOrigin/InteractableJoystick.joystick_y_position / 45
#	return $Plane_Mesh/Yoke/JoystickOrigin/InteractableJoystick.joystick_y_position / 45
	
func _on_PlaneEnterArea_body_entered(body):
	if body.is_in_group("right_hand") or body.is_in_group("left_hand"):
		player_is_seated = true
		emit_signal("plane_entered", self)


func _on_PlaneExitArea_body_entered(body):
	if body.is_in_group("right_hand") or body.is_in_group("left_hand"):
		player_is_seated = false
		emit_signal("plane_exited", self)
		
func _on_PlaneThrottle_plane_throttle_moved(position):
#	pass
	print("Throttle position is: " + str(position)) # Replace with function body.
#	throttle_delta = position / .04

func _on_Yoke_yoke_moved(x_angle, y_angle):
#	pass # Replace with function body.
#	turn_input = x_angle
#	pitch_input = y_angle
	print("X angle is:")
	print(str(x_angle))
	print("Y angle is:")
	print(str(y_angle))
	
