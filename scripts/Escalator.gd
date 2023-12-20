extends Area3D

var player_in_area = false
var escalator_speed = Vector3(0.5, 1, 0)  # Adjust the direction and speed
var last_body :Node3D;
func area_entered(body):
	print("hellow")
	if body.name == "Player":  # Check if the entered body is the player
		player_in_area = true
		body.apply_impulse(escalator_speed)
		last_body = body

func area_exited(body):
	if body.name == "Player":
		player_in_area = false
		last_body = null

func _physics_process(delta):
	if last_body == null:
		return;
	print("hello")
	last_body.apply_impulse(escalator_speed * delta)
