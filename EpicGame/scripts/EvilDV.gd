extends KinematicBody2D

signal dead
signal change_health
var velocity = Vector2()
var direction = 1
var speed = 100
var wind_size = 600
var max_health = 200
export var health:int = max_health
var taxi = preload ("res://scenes/YandexTaxi.tscn")
var lose_catchfraze = "Я проверю ваши лабы через час"
var win_catchfraze = "Вы молодец, но я разочарован("
var is_alive = true



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
	
func _dead():
	is_alive = false
	$Timer.stop()
	
	
	
	
func _changedir():
#	print(get_floor_velocity().y)
#	print(position)
	if position.y - ($Sprite.texture.get_height())/2 <= 0:
		direction = 1
	if position.y + ($Sprite.texture.get_height())/2 >= get_viewport_rect().size.y	:
		direction = -1
	
func _change_health(value):	
	health += value
	if health < 0:
		health = 0
	if health > max_health:
		health = max_health		
	emit_signal("change_health", health)

func _process(delta):
	if(health <= 0):
		emit_signal("dead")
	if is_alive:
		_changedir()
		_fly(delta)
		


func _on_Timer_timeout():
	print ("timeout")
	$Timer.wait_time *= 0.99
	_shoot()
