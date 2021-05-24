extends CanvasLayer

func _set_max_value(value, bar, number):
	bar.max_value = value
	bar.value = value
	number.text = str(value)
	
	
func _ready():
	Global.prev_score = Global.player_score


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$GUI/HBoxContainer/ScoreCounter/Background/Number.text = str(Global.player_score)

func _on_NextBtn_button_up():
	if (Global.is_curr_lvl_won):
		Global.goto_scene()
	

func _on_PauseBtn_button_down():
	get_tree().paused = true
	$EndPanel.visible = true


func _on_PlayBtn_button_down():
	get_tree().paused = false
	$EndPanel.visible = false


func _on_MenuBtn_button_up():
	Global._goto_menu()
	get_tree().paused = false
	Global.player_score = Global.prev_score


func _on_ReloadBtn_button_up():
	Global.reload_scene()
	get_tree().paused = false
	Global.player_score = Global.prev_score
