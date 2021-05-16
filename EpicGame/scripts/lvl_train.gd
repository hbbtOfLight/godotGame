extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.is_on_fly_lvl = false
	$EnemyTimer.start()
	pass

func _aim():
	return $Player.global_position - $EnemyM/Aitch_pos.global_position
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_EnemyTimer_timeout():	
	$EnemyM._shoot(_aim())


func _on_Player_dead():
	$EnemyTimer.stop()
	$HUD/WindowDialog.popup()
	$Player.can_move = false
