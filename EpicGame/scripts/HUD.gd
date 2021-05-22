extends CanvasLayer

var is_won = false

func _set_max_value(value, bar, number):
	bar.max_value = value
	bar.value = value
	number.text = str(value)
	
	
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NextBtn_button_up():
	if (is_won):
		Global.goto_scene()
	else:
		Global.reload_scene()


func _on_PauseBtn_button_down():
	get_tree().paused = true


func _on_PlayBtn_button_down():
	get_tree().paused = false


func _on_MenuBtn_button_up():
	pass # Replace with function body.
