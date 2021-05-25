extends KinematicBody2D

var init_pos
var damage = 5
var speed = 75
var velocity = Vector2(-1,0)
export var direction = -1

func _ready():
	init_pos = global_position
	if direction == 1:
		$AnimatedSprite.flip_h = true


func _physics_process(delta):
	if abs(position.x - init_pos.x) >= 50:
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
	velocity.x = speed * direction * delta
	translate(velocity)


func _on_top_checker_body_entered(body):
	$Timer2.start()
	$AnimatedSprite.play("boom")
	speed = 0
	set_collision_layer_bit(1, false)
	set_collision_mask_bit(0, false)
	$top_checker.set_collision_layer_bit(1, false)
	$top_checker.set_collision_mask_bit(0, false)


func _on_top_checker_area_entered(area):
	$Timer2.start()
	$AnimatedSprite.play("boom")
	speed = 0
	set_collision_layer_bit(1, false)
	set_collision_mask_bit(0, false)
	$top_checker.set_collision_layer_bit(1, false)
	$top_checker.set_collision_mask_bit(0, false)


func _on_attack_checker_body_entered(body):
	if body.is_in_group("Player"):
		$Timer.start()
		speed=1
		$AnimatedSprite.play("bird_attack")
		body._change_health(-damage)
		

func _on_Timer_timeout():
	$Timer.stop()
	speed = 75
	$AnimatedSprite.play("bird_move")
	


func _on_Timer2_timeout():
	queue_free()


func _on_hit_checker_area_entered(area):
	$Timer2.start()
	$AnimatedSprite.play("boom")
	speed = 0
	set_collision_layer_bit(1, false)
	set_collision_mask_bit(0, false)
	$top_checker.set_collision_layer_bit(1, false)
	$top_checker.set_collision_mask_bit(0, false)
