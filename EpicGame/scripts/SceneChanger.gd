extends Node

signal score_upd
var player_max_health = 100
var player_score = 0 
var current_scene = null
var current_scene_name:String
var is_curr_lvl_won  = false
var prev_score = 0


func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	
func goto_scene():
	call_deferred("_deferred_goto_scene", current_scene_name)
	prev_score = player_score
	
	
func _load_scene(path):
	print(current_scene_name)
	print(path)
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	
	
func goto_path_scene(path):	
	call_deferred("_load_scene", path)	

func _deferred_goto_scene(scene_name):
	var path	
	match(scene_name):
		"DesertLvl":
			path = "res://scenes/levels/lvl.tscn"
		"SpaceLvl":
			path = "res://scenes/levels/LevelDV.tscn"
		"GraveLvl":
			path = "res://scenes/levels/CashLvl.tscn"			
		"Cash":
			path = "res://scenes/levels/DesertLvl.tscn"
		"Mothveev":
			path = "res://scenes/levels/SpaceLvl.tscn"
		"DV":
			path = "res://scenes/levels/GraveLvl.tscn"
		_:
			return
	call_deferred("_load_scene", path)
	
func reload_scene():
#	print(current_scene_name)
	call_deferred("_deffered_reload")
	
func _deffered_reload():
	var path
	match(current_scene_name):
		"GraveLvl":
			path = "res://scenes/levels/GraveLvl.tscn"
		"DesertLvl":
			path = "res://scenes/levels/DesertLvl.tscn"	
		"SpaceLvl":
			path = "res://scenes/levels/SpaceLvl.tscn"
		"Cash":
			path = "res://scenes/levels/CashLvl.tscn"
		"Mothveev":
			path = "res://scenes/levels/lvl.tscn"
		"DV":
			path = "res://scenes/levels/LevelDV.tscn"
		_:
			return
	_load_scene(path)
	
func _goto_menu():
	call_deferred("_load_scene", "res://scenes/MainMenu.tscn")	
	
func _update_health(health, barnumber, barvalue):
	barnumber.text = str(health)
	barvalue.value = health
	

	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
