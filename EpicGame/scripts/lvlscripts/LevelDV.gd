extends Node

var taxi_value = 20
onready var health_progress = $HUD/GUI/HBoxContainer/LifeBar/TextureProgress
onready var health_value = $HUD/GUI/HBoxContainer/LifeBar/Count/Background/Number
onready var enemy_progress = $HUD/GUI/HBoxContainer/EnergyBar/TextureProgress
onready var enemy_value = $HUD/GUI/HBoxContainer/EnergyBar/Count/Background/Number


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.is_on_fly_lvl = true
	$HUD._set_max_value($Player.max_health, health_progress, health_value)
	$HUD._set_max_value($EnemyDV.max_health, enemy_progress, enemy_value)	
		


func _on_EnemyDV_dead():
	$EnemyDV._dead()
	$HUD/EndPanel/CatchLabel.text = $EnemyDV.win_catchfraze
	$HUD/EndPanel.visible = true


func _on_Player_dead():
	$EnemyDV/Timer.stop()
	$Player.can_move = false
	$HUD/EndPanel/CatchLabel.text = $EnemyDV.lose_catchfraze
	$HUD/EndPanel.visible = true


#func _on_Bullet_v_apple():
#	$Player.score += taxi_value
#	print ("score!")
#	$HUD/GUI/HBoxContainer/Counters/BombCounter/Background/Number.text = str($Player.score)
	
	




func _on_Player_health_changed(health):
	Global._update_health(health, 	health_value, health_progress)


func _on_EnemyDV_change_health(health):
	Global._update_health(health, enemy_value, enemy_progress)


func _on_NextBtn_button_up():
	Global.goto_scene("res://lvl.tscn")
