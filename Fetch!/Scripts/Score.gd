extends Label


# Script to handle the game score and its label
func _process(delta):
	self.text = str("Score: ") + str(Global.score)

