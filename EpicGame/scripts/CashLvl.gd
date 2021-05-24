extends Node

export var scene_name = "Cash"
onready var health_progress = $HUD/GUI/HBoxContainer/LifeBar/TextureProgress
onready var health_value = $HUD/GUI/HBoxContainer/LifeBar/Count/Background/Number
onready var enemy_progress = $HUD/GUI/HBoxContainer/EnergyBar/TextureProgress
onready var enemy_value = $HUD/GUI/HBoxContainer/EnergyBar/Count/Background/Number


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.is_on_fly_lvl = false
	$HUD._set_max_value($Player.max_health, health_progress, health_value)
	$HUD._set_max_value($EnemyCash.max_health, enemy_progress, enemy_value)	
	Global.current_scene_name = scene_name
	Global.is_curr_lvl_won = false


func _on_Player_dead():
	$HUD/EndPanel/CatchLabel.text = $EnemyCash.lose_catchfrase
	$HUD/EndPanel.visible = true
	$Player.can_move = false

func _on_Player_health_changed(health):
	Global._update_health(health, 	health_value, health_progress)

func _on_EnemyCash_change_health(health):
	Global._update_health(health, 	enemy_value, enemy_progress)


func _on_EnemyCash_dead():
	$EnemyCash.is_dead = true
	Global.is_curr_lvl_won = true
	$HUD/EndPanel/CatchLabel.text = $EnemyCash.win_catchfrase + "\nВы победили финального босса!\nЖивите теперь с этим."
	$HUD/EndPanel/NextBtn.text = "To start"
	$HUD/EndPanel/NextBtn.visible = true
	$HUD/EndPanel.visible = true
