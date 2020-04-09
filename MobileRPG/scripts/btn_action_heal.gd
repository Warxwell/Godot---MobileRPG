extends "res://scripts/btn_action.gd"


func _on_pressed():
	var player = BattleUnits.player
	if player:
		if player.mp >= 8:
			player.hp += 5
			player.mp -= 8
			player.ap -= 1
			
