extends AudioStreamPlayer


func _ready():
	playing = true
	
func _play_shoot():
	if (MusicSettings.sound_effects_enable):
		$ShootEffect.play()
		
		


