extends KinematicBody2D

signal dead
signal health_changed
var played_fail = false
export var is_on_fly_lvl = false
const SPEED = 200
const FLOOR = Vector2(0, -1)
const GRAVITY = 970
const JUMP_POWER = 500
#onready var player_vars = get_node("/root/PlayerGlVars")
var speed = 300
var maxLives = 5
var max_health = Global.player_max_health 
var health = max_health
var score = 0
var damage = 20
var isDashing = false
var velocity = Vector2()
var jumps_left = 2
var isStands = true
var isCrouches = false
const SCALE_MODIFIER = 2
onready var sprite = $Sprite
onready var stand_collision = $StandCollision
onready var crouch_collision = $CrouchCollision
var bullet = preload("res://scenes/Bullet.tscn")
export var can_move = true


func _ready():
	$Sprite.animation = "idle"
	
	
func _move_x(delta):
	if (Input.is_action_pressed("ui_left")):
		velocity.x = -SPEED
		sprite.flip_h = true
		if (not isCrouches):
			$Sprite.animation = "run"
		$BulletPos.position.x = abs($BulletPos.position.x) * (-1)
	
	elif (Input.is_action_pressed("ui_right")):
		velocity.x = SPEED
		sprite.flip_h = false
		if (not isCrouches):
			$Sprite.animation = "run"
		$BulletPos.position.x = abs($BulletPos.position.x)
	
	else: 
		velocity.x = 0
		if (is_on_floor() and not isCrouches):
			$Sprite.animation = "idle"		
		
func _jump():
	if(is_on_floor()):
		jumps_left = 2	
	if(Input.is_action_just_pressed("jump") and jumps_left > 0):
		velocity.y = -JUMP_POWER
		jumps_left -= 1
		$Sprite.animation = "jump"
		
func _gravity(delta):
	if not isDashing: velocity.y += (GRAVITY * delta)

	
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
		$Sprite.animation = "crouch"
		isStands = false
		isCrouches = true	
		stand_collision.disabled = true
		crouch_collision.disabled = false			
		_crawl()

func _crawl():
	stand_collision.disabled = true
	crouch_collision.disabled = false		
	$Sprite.animation = "crouch"


func _stand_up():
	if  not (Input.is_action_pressed("crouch")) and isCrouches:
		if not $UpperRayCast.is_colliding() :
			stand_collision.disabled = false
			crouch_collision.disabled = true	
			isCrouches = false
			isStands = true
			$Sprite.animation = "Idle"
#			print($UpperRayCast.is_colliding())
		if($UpperRayCast.is_colliding()):			
			_crawl()
			
func _shoot():
	if Input.is_action_just_pressed("shoot"):
		AudioNode._play_shoot()
		var bullets = bullet.instance()
		bullets.position = $BulletPos.global_position
		get_parent().add_child(bullets) 
		if not sprite.flip_h:
			bullets.direction = 1
		else:
			bullets.direction = -1
		$Sprite.animation = "shoot"
			
func _fly():
	if (Input.is_action_pressed("fly_up")):
		velocity.y -= speed
	if Input.is_action_pressed("fly_down"):
		velocity.y += speed
		
func _change_health(value):	
	health += value
	if health <= 0:
		health = 0
		$Sprite.animation = "dead"
		emit_signal("dead")	
	if health > max_health:
		health = max_health		
	emit_signal("health_changed", health)
			
	
func _process(delta):
	#Физику поадекватнее переписать
	if (can_move):
		var screen_size = get_viewport_rect().size	
		if not is_on_fly_lvl:
			_move_x(delta)
			_jump()			
			_dash()
			_crouch()
			_stand_up()							
			_gravity(delta)
			velocity = move_and_slide(velocity, FLOOR)	
			
		else:
			_fly()
			position += velocity * delta
			velocity = Vector2()
			position.y = clamp(position.y, 0, screen_size.y)
		_shoot()			
	
		if (position.y >= screen_size.x * 1.5):
			if (not played_fail):
				AudioNode._play_fall()
				played_fail = true
			_change_health(-max_health)

		
	

