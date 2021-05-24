extends Node

export var scene_name = "Space"
onready var health_progress = $HUD/GUI/HBoxContainer/LifeBar/TextureProgress
onready var health_value = $HUD/GUI/HBoxContainer/LifeBar/Count/Background/Number
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	scene_name = self.name
	$Camera2D.player = $Player
	$HUD/GUI/HBoxContainer/EnergyBar.visible = false
	$HUD._set_max_value($Player.max_health, health_progress, health_value)
	Global.current_scene_name = scene_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_health_changed(health):
	Global._update_health(health, 	health_value, health_progress)
	
func _on_Player_dead():
	$Player.can_move = false
	$HUD/EndPanel.visible = true


func _on_Portal_body_entered(body):
	Global.goto_scene()
