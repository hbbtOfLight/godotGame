extends Node

var player_max_health = 100
var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	
func goto_scene(path):

	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
	
func _update_health(health, barnumber, barvalue):
	barnumber.text = str(health)
	barvalue.value = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
