extends Node

var player_max_health = 100
var current_scene = null
var current_scene_name:String

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	
func goto_scene():
	call_deferred("_deferred_goto_scene", current_scene_name)
	
func _load_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
	
	
func goto_path_scene(path):	
	call_deferred("_load_scene", path)
	


func _deferred_goto_scene(scene_name):
	var path
	
	match(scene_name):
		"Cash":
			path = "res://scenes/levels/lvl.tscn"
		"Mothveev":
			path = "res://scenes/levels/LevelDV.tscn"
		"DV":
			path = "res://scenes/levels/CashLvl.tscn"
		_:
			return
	call_deferred("_load_scene", path)
	
func reload_scene():
	call_deferred("_deffered_reload")
	
func _deffered_reload():
	var path
	match(current_scene_name):
		"Cash":
			path = "res://scenes/levels/CashLvl.tscn"
		"Mothveev":
			path = "res://scenes/levels/lvl.tscn"
		"DV":
			path = "res://scenes/levels/LevelDV.tscn"
		_:
			return
	_load_scene(path)
		
		
	
	
	
func _update_health(health, barnumber, barvalue):
	barnumber.text = str(health)
	barvalue.value = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
