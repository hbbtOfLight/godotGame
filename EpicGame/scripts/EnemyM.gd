extends StaticBody2D
class_name EnemyBoss
signal dead
signal change_health

var book_to_throw = preload ("res://scenes/Aitch.tscn")
var max_health = 100
var health = max_health
var lose_catchfrase = "Так как я самый простой и понятный,\n скажите что я вам сейчас скажу? ПЕРЕСДАЧА!!!"
var win_catchfrase = "Садитесь, вам двойка!"
#var velocity_for_book = Vector2()


func _ready():
	$ShootTimer.start()
	
func _shoot(direction):
	var books = book_to_throw.instance()
	books.position = $Aitch_pos.global_position
	books._setup(direction)
	get_parent().add_child(books) 
#	books.velocity = direction
#	books.init_vector = direction

func _death():
	$ShootTimer.stop()
	$Sprite.flip_v = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	


func _on_ShootTimer_timeout():
	pass
#	_shoot(Vector2(-1, -1))
