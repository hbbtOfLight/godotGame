extends Area2D

const speed = 500
var damage = 10
var vel = Vector2()
var direction = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	vel.x = speed * delta * direction
	if (direction == -1):
		$Sprite.flip_h = true
	translate(vel)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_OhrBullet_body_entered(body):
	if (body.name == "Player"):
		body.health -= damage
	if (body.name == "EnemySequrity"):
		return
	queue_free()
