extends Area2D

var damage = 5

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StaticDanger_body_entered(body):
	if body.is_in_group("Player"):
		body._change_health(-damage)
		Global._update_health(body.health, get_parent().health_value, get_parent().health_progress)
