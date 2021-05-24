extends Area2D
export var direction = -1

const speed = 500
var damage = 10
var vel = Vector2()
#const Player = preload("res://Player.gd")

func _physics_process(delta):
	vel.x = speed * delta * direction
#	if (direction == -1):
#		$Sprite.rotation_degrees = -130
	translate(vel)
	if (Global.is_curr_lvl_won):
		queue_free()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier_screen_exited():
	queue_free()


func _on_YandexTaxi_body_entered(body):	
	if body.name == "Player":
		body._change_health(-damage)
		print("player entered")
	if "Enemy" in body.name:
		print("enemy entered")
		return
	else: print ("chalk en")
	queue_free()
		
	


#func _on_YandexTaxi_area_entered(area):
#	queue_free()
