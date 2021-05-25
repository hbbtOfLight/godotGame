extends StaticBody2D
class_name EnemyBoss
signal dead
signal change_health

var book_to_throw = preload ("res://scenes/Aitch.tscn")
var max_health = 100
var health = max_health
var lose_catchfrase = "Так как я самый простой и понятный,\n скажите что я вам сейчас скажу? ПЕРЕСДАЧА!!!"
var win_catchfrase = "Садитесь, вам двойка!"
var hit_score = 5



func _ready():
	pass
	
func _shoot(direction):
	var books = book_to_throw.instance()
	books.position = $Aitch_pos.global_position
	books._setup(direction)
	get_parent().add_child(books) 


func _death():
	$Sprite.flip_v = true
	

func _process(delta):
	if health == 0:
		emit_signal("dead")
		
func _change_health(value):	
	health += value
	if health < 0:
		health = 0
	if health > max_health:
		health = max_health		
	emit_signal("change_health", health)
	



