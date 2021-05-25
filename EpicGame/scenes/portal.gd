extends Area2D


var angspeed = 100


func _ready():
	pass


func _process(delta):
	$Sprite.rotation_degrees += angspeed * delta
