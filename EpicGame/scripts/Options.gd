extends Control

func _ready():
	pass # Replace with function body.



func _on_HSlider_value_changed(value):
	MusicSettings.music_volume = max($CenteredContainer/VBoxContainer/CenterContainer/MusicVolume/MusicSlider.min_value, value)
	if (value <= $CenteredContainer/VBoxContainer/CenterContainer/MusicVolume/MusicSlider.min_value):
		MusicSettings.music_enable = false
	else:
		MusicSettings.music_enable = true


func _on_SoundSlider_value_changed(value):
	MusicSettings.sound_effects_enable = value
	if (value <= $CenteredContainer/VBoxContainer/CenterContainer2/MusicVolume/SoundSlider.min_value):
		MusicSettings.sound_effects_enable = false
	else:
		MusicSettings.sound_effects_enable = true


func _on_Button_button_down():
	Global._goto_menu()
