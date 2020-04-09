extends "res://scripts/btn_action.gd"


func _on_pressed():
	var player = BattleUnits.player
	if player:
		player.blocking = true
		player.ap = 0 # or -= 1
	pass 
