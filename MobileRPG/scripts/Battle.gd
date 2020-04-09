extends Node

const BattleUnits = preload("res://Resources/BattleUnits.tres")

const UiUnits = preload("res://Resources/UiUnits.tres")

export(Array, PackedScene) var enemies = [] #guarda escenas en una lista

onready var battle_Act_btn = $UI/battle_action_btns
onready var anim = $anim
onready var btn_next = $UI/center_cont/btn_next_room
onready var enemy_star_pos = $enemy_position

func _ready():
	
	#var txtbox = UiUnits.textbox
	
	randomize() #para el create enemy
	start_player_turn()
	
	#inicializamos el enemy
	var enemy = BattleUnits.enemy #conectamos acá en vez de la señal que usabamos
	if enemy:
		enemy.connect("ondeath", self, "on_enemy_died") #no hace falta poner el argument


func start_enemy_turn():
	battle_Act_btn.hide()
	#volvemos a conectar en enemy
	var enemy = BattleUnits.enemy
	if enemy and not enemy.is_queued_for_deletion(): #el is_queued es para que no inicie cuando se quiere borrar el enemigo
		enemy.attack()
		yield(enemy,"end_turn")
	start_player_turn()
	
	
func start_player_turn():
	#volvemos a conectar en enemy
	var enemy = BattleUnits.enemy
	if enemy and not enemy.is_queued_for_deletion():
		battle_Act_btn.show() #hacemos visible
	var player = BattleUnits.player
	player.ap = player.max_ap #seteamos al maximo
	player.blocking = false
	yield(player, "end_turn")
	start_enemy_turn()


func on_enemy_died(experience): #agregamos el argument
	
	btn_next.show()
	battle_Act_btn.hide()
	add_experience(experience)
	#add_experience(2)


func create_new_enemy():
	
	enemies.shuffle() # randomiza el orden de los enemigos
	var Enemy = enemies.front() # nos trae le primer enemigo, guardamos la escena, en vez de hacer preload que es enemy array
	var enemy = Enemy.instance() # instanciamos la escena
	enemy_star_pos.add_child(enemy)
	#volvemos a conectar
	enemy.connect("ondeath", self, "on_enemy_died") #self es battle
#	
	var txtbox = UiUnits.textbox
	if txtbox:
			txtbox.text = "New enemy appears!"

	
func _on_btn_next_room_pressed():
	var txtbox = UiUnits.textbox
	if txtbox:
			txtbox.text = ""
	
	btn_next.hide()
	anim.play("new_room_fade")
	yield(anim, "animation_finished")
	var player = BattleUnits.player
	player.ap = player.max_ap
	battle_Act_btn.show()
	create_new_enemy()
	start_player_turn() #reiniciamos el turno del player
	
	
func add_experience(value): #sumamos experiencia
	var txtbox = UiUnits.textbox
	if txtbox:
		txtbox.text = "You got " + str(value) + " exp." 
	# imprimo acá porque el value en set_exp ya va a ser el exp sumado
	
	var player = BattleUnits.player
	player.experience += value 
	pass
