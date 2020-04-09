extends Node

const BattleUnits = preload("res://Resources/BattleUnits.tres")
const UiUnits = preload("res://Resources/UiUnits.tres")

#stats
var max_hp 	= 25
var hp 		= max_hp setget set_hp

var max_ap 	= 3
var ap 		= max_ap setget set_ap

var max_mp 	= 10
var mp 		= max_mp setget set_mp

var level = 1 #nivel en el cual comenzamos
var next_lvl_exp = 5
var experience = 0 setget set_exp

var attack = 4

var blocking = false # para el boton block

signal hp_changed(value)
signal ap_changed(value)
signal mp_changed(value)


signal end_turn #señal para terminar el turno


func _ready():
	BattleUnits.player = self #nos agregamos al battle units al crear
	

func _exit_tree():
	BattleUnits.player = null


func set_hp(value):
	hp = clamp(value, 0, max_hp) #para que no sea menor a 0, solo dentro de value y max hp
	emit_signal("hp_changed", hp)
	
	
func set_ap(value):
	ap = clamp(value, 0, max_ap) 
	emit_signal("ap_changed", ap)
	
	if ap == 0:	# cuando no tengamos mas puntos de accion
		is_blocking()
		emit_signal("end_turn")
	
	
func set_mp(value):
	mp = clamp(value, 0, max_mp)
	emit_signal("mp_changed", mp)


func set_exp(value):
	experience = value #la suma hago en battle.gd
	#print("Actual experience " + str(experience))
	if experience >= next_lvl_exp:
		level += 1
		experience = 0 #reseteamos
		next_lvl_exp = int(next_lvl_exp * 1.5)
		attack += 1
		max_hp += 2
		max_mp += 1
		
		var txtbox = UiUnits.textbox
		if txtbox:
			txtbox.text = "Level Up!, you are now level "+str(level)


func is_blocking():
	if blocking:
		print("Blocking")

