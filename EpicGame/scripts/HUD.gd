extends CanvasLayer

func _set_max_value(value, bar, number):
	bar.max_value = value
	bar.value = value
	number.text = str(value)
	
	
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
