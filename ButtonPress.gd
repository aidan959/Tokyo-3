extends Interactable


@onready var anim_player = $AnimationPlayer
@onready var audio_player = $Clicky

signal button_pressed

# interactable
func get_interaction_text():
	return "to press"

func interact():
	# return if button is in mid animation
	if anim_player.is_playing():
		return
	
	emit_signal("button_pressed")
	
	anim_player.play("Cylinder_001Action_001")
	audio_player.play()

func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("button_pressed")
	

