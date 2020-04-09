extends Control

export (String, MULTILINE) var description = ""

const UiUnits = preload("res://Resources/UiUnits.tres")

func _on_hover_info_mouse_entered():
	var txtbox = UiUnits.textbox
	if txtbox:
		txtbox.text = description


func _on_hover_info_mouse_exited():
	var txtbox = UiUnits.textbox
	if txtbox:
		txtbox.text = ""
