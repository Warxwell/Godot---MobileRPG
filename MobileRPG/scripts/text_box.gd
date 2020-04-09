extends RichTextLabel

const UiUnits = preload("res://Resources/UiUnits.tres")

func _ready():
	UiUnits.textbox = self

func _exit_tree(): #just in case
	UiUnits.textbox = null
