extends Panel


onready var hpLabel = $stats_container/lbl_hp
onready var apLabel = $stats_container/lbl_ap
onready var mpLabel = $stats_container/lbl_mp


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_player_stats_hp_changed(value):
	hpLabel.text = "HP\n"+str(value)


func _on_player_stats_mp_changed(value):
	mpLabel.text = "MP\n"+str(value)


func _on_player_stats_ap_changed(value):
	apLabel.text = "AP\n"+str(value)
