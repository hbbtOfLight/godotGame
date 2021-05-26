extends Area2D
var score_value = 2
var health_value = 5


func _ready():
	pass 


func _on_Valerianka_body_entered(body):
	if body.is_in_group("Player"):
		Global.player_score += score_value
		body._change_health(2)
		queue_free()
		
