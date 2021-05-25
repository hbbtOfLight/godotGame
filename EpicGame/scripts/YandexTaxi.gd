extends Area2D
export var direction = -1

const speed = 500
var damage = 10
var vel = Vector2()


func _physics_process(delta):
	vel.x = speed * delta * direction
	translate(vel)
	if (Global.is_curr_lvl_won):
		queue_free()


func _ready():
	pass 



func _on_VisibilityNotifier_screen_exited():
	queue_free()


func _on_YandexTaxi_body_entered(body):	
	if body.name == "Player":
		body._change_health(-damage)
	if "Enemy" in body.name:
		return
	queue_free()
		
	

