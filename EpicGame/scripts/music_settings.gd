extends Node


var music_enable = true
var sound_effects_enable = true
var music_volume = 0.0 setget set_music_volume
var effects_volume = 0.0 setget set_effects_volume

func set_music_volume(volume):
	music_volume = volume
	AudioNode.volume_db = music_volume
	AudioNode.playing = music_enable
	
func set_effects_volume(volume):
	effects_volume = volume
	var effects = AudioNode.get_children()
	for child in effects:
		child.volume_db = effects_volume
		child.stream_paused = !sound_effects_enable
	



func _ready():
	pass 

