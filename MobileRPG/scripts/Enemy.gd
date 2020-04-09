extends Node2D

const BattleUnits = preload("res://Resources/BattleUnits.tres")

signal ondeath(experience) #
signal end_turn

onready var hpLabel = $l_hp
onready var anim_player = $anim

export (int) var hp = 25 setget set_hp
export (int) var damage = 4
export (int) var experience = 0

func _ready():
	BattleUnits.enemy = self #nos agregamos al battle units al crear
	if hpLabel: # va a querer entrar acá antes de que se cree el hplabel por eso el if
		hpLabel.text = str(hp) + " Hp"
	

func _exit_tree():
	BattleUnits.enemy = null
	

func set_hp(new_hp):
	hp = new_hp
	
	#invalid index text, si el hp del enemigo es distinto que el de arriba (25)
	if hpLabel: # va a querer entrar acá antes de que se cree el hplabel por eso el if
		hpLabel.text = str(hp) + " Hp"


func attack(): #llamado por battle
	yield(get_tree().create_timer(0.4),"timeout")
	anim_player.play("attack")
	yield(anim_player,"animation_finished")
	emit_signal("end_turn")


func deal_Damage(): #llamamos a este durante la animacion attack
	#
	var player = BattleUnits.player
	if player.blocking:
		player.hp -= int(damage/2) #take less damage
		player.mp += 4 #gain more mp to complement
	else:
		BattleUnits.player.hp -= damage #y usamos la variable target acá


func take_damage(amount):
	self.hp -= amount
	
	if is_dead():
		queue_free()
		#emit_signal("ondeath")
		emit_signal("ondeath", self.experience) #
	else:
		anim_player.play("shake")


func is_dead():
	return hp <= 0





