extends Node3D
@export_range(-150.0,200.0) var target_height : float = position.y  # The height you want the building to rise to
@export_range(-150.0,200.0) var start_height : float = position.y  # The height you want the building to rise to

@export_range(0.5,2.0) var rise_speed: float = 1.0  # The speed at which the building will rise

@export var is_rising: bool = false

func _ready():
	# Start with the building underground
	position.y = start_height

func _process(delta):
	if is_rising:
		position.y += rise_speed * delta
		if position.y >= target_height:
			position.y = target_height
			is_rising = false

func raise_building():
	is_rising = true

func _on_button_pressed():
	is_rising = true

