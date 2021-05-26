extends Area2D

var init_vector
var speed = 70
var damage = 5
var rotation_speed = 10


func _ready():
	pass 
	
func _setup(vector):
	init_vector = vector


func _process(delta):
	position += init_vector.normalized() * speed * delta
	rotation_degrees += rotation_speed * delta
	if (Global.is_curr_lvl_won):
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()




func _on_Aitch_body_entered(body):
	if (body.name == "Player"):
		body._change_health(-damage)
		queue_free()
