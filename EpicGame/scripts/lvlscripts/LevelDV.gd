extends Node

var taxi_value = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.is_on_fly_lvl = true
	$HUD._set_max_value($Player.max_health, $HUD/GUI/HBoxContainer/Bars/LifeBar/TextureProgress, $HUD/GUI/HBoxContainer/Bars/LifeBar/Count/Background/Number)
	$HUD._set_max_value($EnemyDV.max_health, $HUD/GUI/HBoxContainer/Bars/EnergyBar/TextureProgress, $HUD/GUI/HBoxContainer/Bars/EnergyBar/Count/Background/Number)	
	
	


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
	
	
func _update_health(health, barnumber, barvalue):
	barnumber.text = str(health)
	barvalue.value = health



func _on_Player_health_changed(health):
	_update_health(health, 	$HUD/GUI/HBoxContainer/Bars/LifeBar/Count/Background/Number, 
	$HUD/GUI/HBoxContainer/Bars/LifeBar/TextureProgress)


func _on_EnemyDV_change_health(health):
	_update_health(health, $HUD/GUI/HBoxContainer/Bars/EnergyBar/Count/Background/Number, $HUD/GUI/HBoxContainer/Bars/EnergyBar/TextureProgress)
