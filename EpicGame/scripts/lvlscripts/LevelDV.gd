extends Node

export var scene_name = "DV"
onready var health_progress = $HUD/GUI/HBoxContainer/LifeBar/TextureProgress
onready var health_value = $HUD/GUI/HBoxContainer/LifeBar/Count/Background/Number
onready var enemy_progress = $HUD/GUI/HBoxContainer/EnergyBar/TextureProgress
onready var enemy_value = $HUD/GUI/HBoxContainer/EnergyBar/Count/Background/Number


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.is_on_fly_lvl = true
	$HUD._set_max_value($Player.max_health, health_progress, health_value)
	$HUD._set_max_value($EnemyDV.max_health, enemy_progress, enemy_value)	
	Global.current_scene_name = scene_name
	Global.is_curr_lvl_won = false
		


func _on_EnemyDV_dead():
	$EnemyDV._dead()
	$HUD/EndPanel/CatchLabel.text = $EnemyDV.win_catchfraze	
	$HUD/EndPanel/NextBtn.visible = true
	Global.is_curr_lvl_won = true
	$HUD/EndPanel.visible = true



func _on_Player_dead():
	$EnemyDV/Timer.stop()
	$Player.can_move = false
	$HUD/EndPanel/CatchLabel.text = $EnemyDV.lose_catchfraze
	$HUD/EndPanel.visible = true



func _on_Player_health_changed(health):
	Global._update_health(health, 	health_value, health_progress)


func _on_EnemyDV_change_health(health):
	Global._update_health(health, enemy_value, enemy_progress)


func _on_NextBtn_button_up():
	Global.goto_scene()
