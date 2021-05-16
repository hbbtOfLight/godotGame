extends KinematicBody2D

var velocity = Vector2()
var direction = 1
var speed = 100
var wind_size = 600
export var health = 200
var taxi = preload ("res://scenes/YandexTaxi.tscn")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print(name)
	
func _fly(delta):
	velocity.y = speed * delta * direction
	translate(velocity)
	
func _shoot():
	var bullet = taxi.instance()
	bullet.position = $TaxiPos.global_position
	get_parent().add_child(bullet)
	
	
	
	
func _changedir():
	print(get_floor_velocity().y)
	print(position)
	if position.y - ($Sprite.scale.y)/2 <= 0:
		direction = 1
	if position.y - ($Sprite.scale.y)/2 >= get_viewport_rect().size.y	:
		direction = -1
	

func _process(delta):
	_changedir()
	_fly(delta)


func _on_Timer_timeout():
	print ("timeout")
	_shoot()
