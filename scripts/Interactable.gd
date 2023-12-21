extends Node

class_name Interactable

func get_text():
	push_error("Interactable must be inherited and get_text overridden.")
	
func interact():
	push_error("Interactable must be inherited and interact overridden.")
