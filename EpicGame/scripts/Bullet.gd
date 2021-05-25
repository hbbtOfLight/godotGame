extends Area2D

export var direction = 1

const speed = 500
var damage = 10
var vel = Vector2()
signal v_apple
class_name bullet


func _physics_process(delta):
	vel.x = speed * delta * direction
	if (direction == -1):
		$Sprite.rotation_degrees = -130
	translate(vel)


func _ready():
	pass


func _on_NotifyVisibility_screen_exited():
	queue_free()

func _on_Bullet_body_entered(body):
	if "Enemy" in body.name:
		body._change_health(-damage)
		Global.player_score += body.hit_score
	if body.name == "Player":
		body._change_health(-damage)
	queue_free()


func _on_Bullet_area_entered(area):
	emit_signal("v_apple")
	queue_free()
