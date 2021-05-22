extends Node

export var scene_name = "Mothveev"
onready var health_progress = $HUD/GUI/HBoxContainer/LifeBar/TextureProgress
onready var health_value = $HUD/GUI/HBoxContainer/LifeBar/Count/Background/Number
onready var enemy_progress = $HUD/GUI/HBoxContainer/EnergyBar/TextureProgress
onready var enemy_value = $HUD/GUI/HBoxContainer/EnergyBar/Count/Background/Number



# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.is_on_fly_lvl = false
	$HUD._set_max_value($Player.max_health, health_progress, health_value)
	$HUD._set_max_value($EnemyM.max_health, enemy_progress, enemy_value)	
	$EnemyTimer.start()	
	Global.current_scene_name = scene_name


func _aim():
	return $Player.global_position - $EnemyM/Aitch_pos.global_position



func _on_EnemyTimer_timeout():	
	$EnemyM._shoot(_aim())


func _on_Player_dead():
	$EnemyTimer.stop()
	$Player.can_move = false
	$HUD/EndPanel/CatchLabel.text = $EnemyM.lose_catchfrase
	$HUD/EndPanel/NextBtn.text = "Replay"
	$HUD/EndPanel.visible = true
	$Player.can_move = false


func _on_Player_health_changed(health):
	Global._update_health(health, 	health_value, health_progress)


func _on_EnemyM_change_health(health):
	Global._update_health(health, 	enemy_value, enemy_progress)


func _on_EnemyM_dead():
	$EnemyTimer.stop()
	$EnemyM._death()
	$HUD/EndPanel/CatchLabel.text = $EnemyM.win_catchfrase
	$HUD/EndPanel.visible = true
	$HUD.is_won = true
