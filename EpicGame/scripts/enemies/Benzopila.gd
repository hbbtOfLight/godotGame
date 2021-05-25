extends Area2D


var velocity = Vector2()
var direction = 1
var speed = 100
var angspeed = 360
var damage = 7


func _ready():
	pass
	
func _fly(delta):
	velocity.y = speed * delta * direction
	translate(velocity)
	

func _changedir():
	var delpos = $Sprite.texture.get_height()* $Sprite.scale.y/2
	if position.y - delpos <= 0:
		direction = 1
	if position.y + delpos >= get_viewport_rect().size.y	:
		direction = -1
		
func _process(delta):
	rotation_degrees += angspeed * delta
	_fly(delta)
	_changedir()
	


func _on_Benzopila_body_entered(body):
	if body.is_in_group ("Player"):
		body._change_health(-damage)
