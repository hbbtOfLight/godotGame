extends Area2D

var init_vector
var speed = 70
var damage = 7
var rotation_speed = 130


func _ready():
	pass # Replace with function body.
	
func _setup(vector):
	init_vector = vector


func _process(delta):
	position += init_vector.normalized() * speed * delta
	rotation_degrees += rotation_speed * delta
	if (Global.is_curr_lvl_won):
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


#func _on_Aitch_body_entered(body):
#	if body.is_in_group("Player"):


func _on_Trost_body_entered(body):
	if (body.is_in_group("Player")):
		body._change_health(-damage)
		queue_free()


