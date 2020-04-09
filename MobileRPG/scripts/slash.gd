extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_anim_animation_finished(anim_name):
	queue_free()
