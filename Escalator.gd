extends Area3D

var player_in_area = false
var escalator_speed = Vector3(0.5, 1, 0)  # Adjust the direction and speed
var last_body :Node3D;
func _on_EscalatorArea_body_entered(body):
	if body.name == "Player":  # Check if the entered body is the player
		player_in_area = true

func _on_EscalatorArea_body_exited(body):
	if body.name == "Player":
		player_in_area = false

func _physics_process(delta):
	if last_body == null:
		pass;

	last_body.translate(escalator_speed * delta)
