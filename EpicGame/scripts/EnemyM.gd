extends StaticBody2D
class_name EnemyBoss
signal dead

var book_to_throw = preload ("res://scenes/Aitch.tscn")
var health = 100
var catch_frase = "Так как я самый простой и понятный, скажите что я вам сейчас скажу? \n ПЕРЕСДАЧА!!!"
#var velocity_for_book = Vector2()


func _ready():
	$ShootTimer.start()
	
func _shoot(direction):
	print("shoot")
	var books = book_to_throw.instance()
	books.position = $Aitch_pos.global_position
	books.velocity = direction
	get_parent().add_child(books) 
	books.velocity = direction
	books.init_vector = direction

func _death():
	$ShootTimer.stop()
	$Sprite.flip_v = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health == 0:
		emit_signal("dead")


func _on_EnemyM_dead():
	_death() # Replace with function body.


func _on_ShootTimer_timeout():
	pass
#	_shoot(Vector2(-1, -1))
