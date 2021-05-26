extends Control
onready var music_slider = $CenteredContainer/VBoxContainer/CenterContainer/MusicVolume/MusicSlider
onready var effects_slider = $CenteredContainer/VBoxContainer/CenterContainer2/MusicVolume/SoundSlider

func _ready():
	music_slider.value = max (music_slider.min_value, MusicSettings.music_volume)
	effects_slider.value = max(effects_slider.min_value, MusicSettings.effects_volume)



func _on_HSlider_value_changed(value):
	MusicSettings.music_volume = max(music_slider.min_value, value)
	if (value <= music_slider.min_value):
		MusicSettings.music_enable = false
	else:
		MusicSettings.music_enable = true


func _on_SoundSlider_value_changed(value):
	MusicSettings.effects_volume = value
	if (value <= effects_slider.min_value):
		MusicSettings.sound_effects_enable = false
	else:
		MusicSettings.sound_effects_enable = true


func _on_Button_button_down():
	Global._goto_menu()
