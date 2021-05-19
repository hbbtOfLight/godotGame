extends KinematicBody2D

signal dead
signal health_changed
#class_name Player
export var is_on_fly_lvl = false
const SPEED = 200
const FLOOR = Vector2(0, -1)
const GRAVITY = 970
const JUMP_POWER = 500
#onready var player_vars = get_node("/root/PlayerGlVars")
var speed = 300
var maxLives = 5
var max_health = Global.player_max_health # потом заменить на глобальную, если получится
var health = max_health
var score = 0
var damage = 20
#var jumpForce : int = 8000
#var gravity : int = 450
#var isOnFloor = true
var isDashing = false
var velocity = Vector2()
#var running_friction = 0.9
#var stopping_friction = 0.5
var jumps_left = 2
var isStands = true
var isCrouches = false
const SCALE_MODIFIER = 2
onready var sprite = $Sprite
onready var stand_collision = $StandCollision
onready var crouch_collision = $CrouchCollision
var stand_texture = preload("res://dedus.png")
#var crawl_texture = preload("res://dedus_croaching.png")
var bullet = preload("res://scenes/Bullet.tscn")
export var can_move = true

func _ready():
	print(name)
	pass # Replace with function body.
	
func _move_x(delta):
	if (Input.is_action_pressed("ui_left")):
		velocity.x = -SPEED
		sprite.flip_h = true
		#$BulletPos.position.x = abs($BulletPos.position.x) * (-1)
	
	elif (Input.is_action_pressed("ui_right")):
		velocity.x = SPEED
		sprite.flip_h = false
	
	else: velocity.x = 0
	
	
		#$BulletPos.position.x = abs($BulletPos.position.x)
		
		
func _jump():
	if(is_on_floor()):
		jumps_left = 2	
	if(Input.is_action_just_pressed("jump") and jumps_left > 0):
#		if velocity.y > 0: 		velocity.y = 0
		velocity.y = -JUMP_POWER
		jumps_left -= 1
#	if(Input.is_action_just_released("jump") and velocity.y < 0):
#		velocity.y = 0
		
		
#func _friction():
#	var isRunning = (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ul_right"))
#	if(isRunning):
#		velocity.x *= running_friction
#	else:
#		velocity.x *= stopping_friction
		
func _gravity(delta):
	if not isDashing: velocity.y += (GRAVITY * delta)
#	if (velocity.y > jumpForce):
#		velocity.y = gravity
	
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
		
func _change_health(value):	
	health += value
	if health < 0:
		health = 0
	if health > max_health:
		health = max_health		
	emit_signal("health_changed", health)
	
func _process(delta):
	#Физику поадекватнее переписать
	if (can_move):
		if not is_on_fly_lvl:
			_move_x(delta)
			_jump()
#			_friction()#			
			_dash()
			_crouch()
			_stand_up()					
#			position += velocity * delta		
			_gravity(delta)
			velocity = move_and_slide(velocity, FLOOR)	
			
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
