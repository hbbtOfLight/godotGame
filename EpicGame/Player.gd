extends KinematicBody2D

signal dead
class_name Player
export var is_on_fly_lvl = true
var speed = 300
var maxLives = 5
var health = 50
var score = 0
var damage = 20
var jumpForce : int = 10000
var gravity : int = 450
#var isOnFloor = true
var isDashing = false
var velocity = Vector2()
var running_friction = 0.9
var stopping_friction = 0.5
var jumps_left = 2
var isStands = true
var isCrouches = false
const SCALE_MODIFIER = 2
onready var sprite = $Sprite
onready var stand_collision = $StandCollision
onready var crouch_collision = $CrouchCollision
var stand_texture = preload("res://dedus.png")
var crawl_texture = preload("res://dedus_croaching.png")
var bullet = preload("res://scenes/Bullet.tscn")
export var can_move = true

func _ready():
	print(name)
	pass # Replace with function body.
	
func _move_x(delta):
	if (Input.is_action_pressed("ui_left")):
		velocity.x -= speed
		sprite.flip_h = true
		#$BulletPos.position.x = abs($BulletPos.position.x) * (-1)
	
	if (Input.is_action_pressed("ui_right")):
		velocity.x += speed
		sprite.flip_h = false
		#$BulletPos.position.x = abs($BulletPos.position.x)
		
		
func _jump():
	if(is_on_floor()):
		jumps_left = 2	
	if(Input.is_action_just_pressed("jump") and jumps_left > 0):
		if velocity.y > 0: 		velocity.y = 0
		velocity.y -= jumpForce
		jumps_left -= 1
	if(Input.is_action_just_released("jump") and velocity.y < 0):
		velocity.y = 0
		
		
func _friction():
	var isRunning = (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ul_right"))
	if(isRunning):
		velocity.x *= running_friction
	else:
		velocity.x *= stopping_friction
		
func _gravity():
	if not isDashing: velocity.y += gravity
	if (velocity.y > jumpForce):
		velocity.y = gravity
	
func _dash():
	var can_dash: bool = false
	var dash_vector = Vector2()
	if (is_on_floor()): can_dash = true
	if Input.is_action_pressed("ui_right"): dash_vector = Vector2(1, 0)
	if Input.is_action_pressed("ui_left"): dash_vector = Vector2(-1, 0)
	if (can_dash and Input.is_action_just_pressed("dash")):
		velocity = dash_vector.normalized() * 10000
		can_dash = false
		isDashing = true
		yield (get_tree().create_timer(0.5), "timeout")
		isDashing = false

func _crouch():
	if Input.is_action_pressed("crouch") and isStands:
		print(sprite.texture.get_height())
		#move_local_y((SCALE_MODIFIER/2)/sprite.texture.get_height())
		_crawl()

func _crawl():
	sprite.scale.y /= SCALE_MODIFIER
	stand_collision.scale.y /= SCALE_MODIFIER
	sprite.position.y += sprite.texture.get_height() / (4 * SCALE_MODIFIER)	
	stand_collision.position.y += sprite.texture.get_height() / (4 * SCALE_MODIFIER)		
	isStands = false
	isCrouches = true


func _stand_up():
	if not Input.is_action_pressed("crouch") and isCrouches and not $UpperRayCast.is_colliding() :
		sprite.position.y -= sprite.texture.get_height() / (4 * SCALE_MODIFIER)	
		stand_collision.position.y -= sprite.texture.get_height() / (4 * SCALE_MODIFIER)		
		sprite.scale.y *= SCALE_MODIFIER
		stand_collision.scale.y *= SCALE_MODIFIER		
		isCrouches = false
		isStands = true
		print($UpperRayCast.is_colliding())
		if($UpperRayCast.is_colliding()):			
			_crawl()
			
func _shoot():
	if Input.is_action_just_pressed("shoot"):
		var bullets = bullet.instance()
		bullets.position = $BulletPos.global_position
		get_parent().add_child(bullets) 
		if not sprite.flip_h:
			bullets.direction = 1
		else:
			bullets.direction = -1
			
func _fly():
	if (Input.is_action_pressed("fly_up")):
		velocity.y -= speed
	if Input.is_action_pressed("fly_down"):
		velocity.y += speed

#func _crouch():
#	if Input.is_action_pressed("crouch") and isStands:
#		stand_collision.disabled = true
#		crouch_collision.disabled = false
#		sprite.transform.rotated(PI/2)
#		#sprite.texture = crawl_texture
#		isStands = false
#		isCrouches = true
#
#func _stand_up():
#	if (Input.is_action_just_released("crouch") and isCrouches):
#		stand_collision.disabled = false
#		crouch_collision.disabled = true
#	#	sprite.texture = stand_texture
#		sprite.transform.rotated(-PI/2)
#		isCrouches = false
#		isStands = true
		
		
		
		
		
	
func _process(delta):
	#Физику поадекватнее переписать
	#velocity.y += gravity
	if (can_move):
		if not is_on_fly_lvl:
			_move_x(delta)
			_jump()
			_friction()
			_gravity()
			_dash()
			_crouch()
			_stand_up()					
			position += velocity * delta		
			velocity = move_and_slide(velocity, Vector2.UP)
			velocity = Vector2()			
		else:
			_fly()
			position += velocity * delta
			velocity = Vector2()
		_shoot()
		var screen_size = get_viewport_rect().size	
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)
		
	
		
	if (health <= 0):
		emit_signal("dead")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
