extends Area2D

export var direction = 1

const speed = 500
var damage = 10
var vel = Vector2()
class_name bullet
#const Player = preload("res://Player.gd")

func _physics_process(delta):
	vel.x = speed * delta * direction
	if (direction == -1):
		$Sprite.rotation_degrees = -130
	translate(vel)


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_NotifyVisibility_screen_exited():
	queue_free()

func _on_Bullet_body_entered(body):
#	var enemy = body as EnemyBoss
	if "Enemy" in body.name:
		body.health -= damage
		print(body.health)
	if body.name == "Player":
		return
#	enemy = body as Player
#	if enemy:
#		return
	queue_free()


