extends "res://scripts/btn_action.gd"

const Slash = preload("res://scene/slash.tscn") #para cargar el slash

func _on_pressed():
	var enemy = BattleUnits.enemy 
	var player = BattleUnits.player 
	if enemy and player:
		create_slash(enemy.global_position)
		enemy.take_damage(player.attack)
		player.mp += 2
		player.ap -= 1


func create_slash(position):
	var slash = Slash.instance()
	var main = get_tree().current_scene
	main.add_child(slash)
	slash.global_position = position
