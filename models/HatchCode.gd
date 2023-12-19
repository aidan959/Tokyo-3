extends Node3D
@onready var animation_player :AnimationPlayer = $AnimationPlayer
signal button_pressed
func open_hatch():
		animation_player.play("Cube_002Action",-1,randf_range(0.7,1.0))
	
