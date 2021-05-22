extends MarginContainer

#const first_scene = preload("res://scenes/levels/lvl.tscn")


onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/Selector
onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector
onready var selector_four = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
var current_selection = 0

func _ready():
	set_current_selection(0)
func _process(delta):
	if Input.is_action_just_pressed("ui_down") and current_selection<3:
		current_selection+=1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_up") and current_selection>0:
		current_selection-=1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection)
		
func handle_selection(_current_selection):
	if _current_selection == 0:
		Global.goto_path_scene("res://scenes/levels/lvl.tscn")
#		get_parent().add_child(first_scene.instance())
		queue_free()
	elif _current_selection == 1:
		print("Loading the game")
	elif _current_selection == 2:
		print("Add options!")
	elif _current_selection == 3:
		get_tree().quit()
	
	
	
	
func set_current_selection(_current_selection):
	selector_one.text=""
	selector_two.text=""
	selector_three.text=""
	selector_four.text=""
	if current_selection == 0 :
		selector_one.text=">"
	elif current_selection == 1 :
		selector_two.text=">"
	elif current_selection == 2 :
		selector_three.text=">"
	elif current_selection == 3 :
		selector_four.text=">"
