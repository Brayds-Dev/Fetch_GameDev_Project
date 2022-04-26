extends Control



# Function to allow keyboard access to buttons on menu
func _ready():
	$Panel/VBoxContainer/StartButton.grab_focus()


# Load the first level on press
func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")
	Global.time = 60
	Global.score = 0

# Quit the game on pressed
func _on_Button2_pressed():
	get_tree().quit()
