extends Area2D
class_name BookOfPunishment
export var init_vector = Vector2()
export var velocity = Vector2(-1, -1)
var speed = 45
var damage = 10



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if(velocity.length()<=0.00001):
		velocity = init_vector
	velocity.x *= (speed * delta)
	velocity.y *= (speed * delta)
	translate(velocity.normalized())


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


#func _on_Aitch_body_entered(body):
#	if body.is_in_group("Player"):


func _on_Aitch_body_entered(body):
	if (body.name == "Player"):
		body.health -= damage
		queue_free()
		print(body.health)
