extends AudioStreamPlayer3D


func _on_ready():
	connect("finished", Callable(self,"_on_loop_sound").bind(self))
	play()

func _on_loop_sound(player):
	stream_paused = false
