extends StaticBody2D
var bullet = preload("res://scenes/OhrBullet.tscn")
var health = 200
var bullets_dir = 1
var pos
var health_add = 2


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pos = global_position


func _on_TeleportTimer_timeout():
	if (get_viewport_rect().size.x - position.x > position.x):
		position.x = get_viewport_rect().size.x - pos.x
	else: position.x = pos.x
#	position.x = get_viewport_rect().size.x - position.x
	$BulletPosition.position.x = -$BulletPosition.position.x
	print($BulletPosition.position.x)
	$Sprite.flip_h = not $Sprite.flip_h
	bullets_dir = -bullets_dir
	
func _shoot():
	var bull1 = bullet.instance()
	bull1.position = $BulletPosition.global_position
	bull1.direction = bullets_dir
	get_parent().add_child(bull1)

func _on_ShootTimer_timeout():
	_shoot()


func _on_HealthAddTimer_timeout():
	health += health_add
