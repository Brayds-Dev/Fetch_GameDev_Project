extends Control

# This is the script for the level 1 complete menu screen

# Function to allow keyboard access to buttons on menu
func _ready():
	$Panel/VBoxContainer/StartButton.grab_focus()


# Enter the next level and reset the global values
func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Level2.tscn")
	Global.time = 60
	Global.score = 0

# Quit the game when pressed
func _on_Button2_pressed():
	get_tree().quit()
