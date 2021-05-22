extends StaticBody2D


signal change_health
signal dead
onready var thermos = preload("res://scenes/Thermos.tscn")
export var rotate_speeds = [90.0, 80.0, 60.0]
onready var pointers = [$Pointer, $Pointer2, $Pointer3]
onready var rays = [$Pointer/RayCast2D, $Pointer2/RayCast2D, $Pointer3/RayCast2D]
onready var things = [preload("res://scenes/Thermos.tscn"), preload("res://scenes/PascalABC.tscn"), preload("res://scenes/Trost.tscn")]
#onready var pointer = $Pointer
#onready var ray = $Pointer/RayCast2D
var lose_catchfrase = "Куда вас послать чтобы стало понятно?"
var win_catchfrase = "Закройте ваш ноутбук"

var angspeed = 100
var max_health = 300
var health = max_health


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _shoot():
	for i in range(pointers.size()):
		if (rays[i].is_colliding()):
			if (rays[i].get_collider() != null and rays[i].get_collider().is_in_group ("Player")):
				var temp = things[i].instance()
				add_child(temp)
				temp.global_position = global_position
				temp.rotation_degrees = rotation_degrees + 90
				temp._setup(rays[i].get_collision_point() - position)
			
func _change_health(value):
	health += value
	if health < 0:
		health = 0
	if health > max_health:
		health = max_health		
	emit_signal("change_health", health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$portal.rotation_degrees += angspeed * delta
	for i in range(pointers.size()):
		pointers[i].rotation_degrees += rotate_speeds[i] * delta
		_shoot()
