extends KinematicBody2D

var speed = 20
const FLOOR = Vector2(0, -1)
const GRAVITY = 970
var velocity = Vector2()
var direction = 1
var damage = 3
var bullet = preload("res://scenes/CactusBullet.tscn")


func _ready():
	$floor_checker.position.x = $body.shape.get_extents().x * direction


func _physics_process(delta):
	velocity.x = speed * direction
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, FLOOR)
	if is_on_wall() or not $floor_checker.is_colliding():
		direction *= -1
		$BulletPos.position.x = -$BulletPos.position.x
		$floor_checker.position.x = $body.shape.get_extents().x * direction


func _on_top_checker_body_entered(body):
	if body.is_in_group("Player"):
		$Timer.start()
		speed=0
		body._change_health(-damage)
	
	
func _on_Timer_timeout():
	$Timer.stop()
	speed = 50
	$AnimatedSprite.play("cactus_move")


func _on_body_ready():
	pass # Replace with function body.


func _on_hit_checker_area_entered(area):

	$AnimatedSprite.play("boom")
	$Timer2.start()
	speed = 0
	set_collision_layer_bit(1, false)
	set_collision_mask_bit(0, false)
	$hit_checker.set_collision_layer_bit(1, false)
	$hit_checker.set_collision_mask_bit(0, false)
	$top_checker.set_collision_layer_bit(1, false)
	$top_checker.set_collision_mask_bit(0, false)
	
func _on_Timer2_timeout():
	queue_free()
	
func _shoot():
	var bullets = bullet.instance()
	bullets.position = $BulletPos.global_position
	get_parent().add_child(bullets) 
	bullets.direction = direction

func _on_ShootTimer_timeout():
	_shoot()
