extends Label

# Script to handle the game time and label
func _on_Timer_timeout():
	Global.time -= 1
	self.text = str("Time: ") + str(Global.time)
