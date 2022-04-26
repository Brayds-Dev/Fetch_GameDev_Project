extends Control

# Script to handle Game Over scene

# Function to allow keyboard access to buttons on menu
func _ready():
	$Panel/VBoxContainer/StartButton.grab_focus()


# Return to start menu when pressed
func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")

# Quit the game when pressed
func _on_Button2_pressed():
	get_tree().quit()
