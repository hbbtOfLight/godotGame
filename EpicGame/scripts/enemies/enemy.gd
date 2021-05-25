extends KinematicBody2D

var damage = 3
var speed = 50
var velocity = Vector2()
export var direction = -1

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$floor_checker.position.x = $body.shape.get_extents().x * direction


func _physics_process(delta):
	
	if is_on_wall() or not $floor_checker.is_colliding() and is_on_floor():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$floor_checker.position.x = $body.shape.get_extents().x * direction
	
	velocity.y += 20
	
	velocity.x = speed * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_top_checker_body_entered(body):
	$AnimatedSprite.play("boom")
	$Timer2.start()
	speed = 0
	set_collision_layer_bit(1, false)
	set_collision_mask_bit(0, false)
	$top_checker.set_collision_layer_bit(1, false)
	$top_checker.set_collision_mask_bit(0, false)
	$attack_checker.set_collision_layer_bit(1, false)
	$attack_checker.set_collision_mask_bit(0, false)


func _on_top_checker_area_entered(area):
	$AnimatedSprite.play("boom")
	$Timer2.start()
	speed = 0
	set_collision_layer_bit(1, false)
	set_collision_mask_bit(0, false)
	$top_checker.set_collision_layer_bit(1, false)
	$top_checker.set_collision_mask_bit(0, false)
	$attack_checker.set_collision_layer_bit(1, false)
	$attack_checker.set_collision_mask_bit(0, false)


func _on_attack_checker_body_entered(body):
	if body.is_in_group("Player"):
		$Timer.start()
		speed=0
		$AnimatedSprite.play("bug_attack")
		body._change_health(-damage)


func _on_Timer_timeout():
	$Timer.stop()
	speed = 50
	$AnimatedSprite.play("bug_move")


func _on_Timer2_timeout():
	queue_free()
